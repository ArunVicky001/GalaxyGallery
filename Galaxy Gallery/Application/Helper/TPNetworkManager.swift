//
//  TPNetworkManager.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation
import Alamofire
import SwiftyJSON

private extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String: Any] ?? [:]
    }
}

public protocol CancellableRequest {
    func cancelRequest()
}

extension Alamofire.DataRequest: CancellableRequest {
    public func cancelRequest() {
        self.cancel()
    }
}

public class TPNetworkManager {
    var additionalParams: [String: Any] = [:]
    public lazy var reachabilityManager = try? NetworkReachabilityManager()
    private let session: Session
    private let baseURL: String
    
    public init(baseURL: String, additionalParams: [String: Any] = [:]) {
        // setup base URL for api services
        self.baseURL = baseURL
        let configuration = URLSessionConfiguration.af.default
        self.additionalParams = additionalParams
        self.session = Session(configuration: configuration)
    }
    
    @discardableResult
    public func callAPI<T: NetworkParser>(_ method: HTTPMethod,
                                          url: String,
                                          needsErrorPrompt: Bool = false,
                                          parameters: Encodable? = nil,
                                          isForceRawData: Bool = false,
                                          paramEncoding: ParameterEncoding? = nil,
                                          additionalHeaders: [String: String]? = nil,
                                          intercepter: RequestInterceptor? = nil,
                                          completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) -> CancellableRequest?
    {        
        var encoding: ParameterEncoding = URLEncoding(arrayEncoding: .noBrackets, boolEncoding: .literal)
        if let customEncoding = paramEncoding {
            encoding = customEncoding
        }
        let headers: HTTPHeaders? = additionalHeaders != nil ? HTTPHeaders(additionalHeaders!) : nil
        let paramDict = merge(dict1: parameters?.dictionary, dict2: additionalParams)
        
        return session.request(url,
                               method: method,
                               parameters: paramDict,
                               encoding: encoding,
                               headers: headers,
                               interceptor: intercepter)
            .cURLDescription { data in
                #if DEBUG
                    print("Curl : \(data)")
                #endif
            }
            .validate { (_, response, data) -> DataRequest.ValidationResult in
                switch response.statusCode {
                case 200 ..< 300:
                    return .success(())
                case 401:
                    return .failure(NetworkServiceError.unauthenticated)
                case 502:
                    return .failure(NetworkServiceError.serviceUnavailable)
                case 503:
                    return .failure(NetworkServiceError.serverUnderMaintenance)
                default:
                    if let data = data {
                        let json = JSON(data)
                        let error = NetworkError(from: json, httpStatusCode: response.statusCode)
                        return .failure(NetworkServiceError.serverError(error))

                    } else {
                        return .failure(NetworkServiceError.invalidResponse)
                    }
                }
            }
            .responseJSON { response in
                #if DEBUG
                print("Request: \(String(describing: response.request)) \nResponse : \(response)")
                #endif
                self.mapResponse(response: response, completionHandler: completionHandler)
            }
    }
        
    private func merge(dict1: [String: Any]?, dict2: [String: Any]?) -> [String: Any] {
        var res = dict1 ?? [:]
        
        for each in dict2 ?? [:] {
            res[each.key] = each.value
        }
        return res
    }
    
    private func mapResponse<T: NetworkParser>(response: AFDataResponse<Any>, completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) {
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            handleSuccess(json: json, completionHandler: completionHandler) // parse corresponding data
        case .failure(let error):
            handleError(error: error, completionHandler: completionHandler)
        }
    }
    
    private func handleSuccess<T: NetworkParser>(json: JSON, completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) {
        if T.self is StructuredParser.Type {
            do {
                let data = try StructuredParserData<T>(from: json).data
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(.parseError(error)))
            }
        } else {
            do {
                let data = try T(from: json)
                completionHandler(.success(data))
            } catch {
                completionHandler(.failure(.parseError(error)))
            }
        }
    }
    
    private func handleError<T:NetworkParser>(error: AFError, completionHandler: @escaping (Swift.Result<T, NetworkServiceError>) -> Void) {
        if let error = error.underlyingError as? NetworkServiceError {
            completionHandler(.failure(error))
        } else {
            completionHandler(.failure(.responseError(error)))
        }
    }
    
}


