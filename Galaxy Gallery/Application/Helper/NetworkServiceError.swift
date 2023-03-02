//
//  NetworkServiceError.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation

import Foundation
import SwiftyJSON

public enum NetworkServiceError: Error {
    case noInternet
    case invalidURL
    case invalidResponse
    case unauthenticated
    case notFound
    case serviceUnavailable
    case serverUnderMaintenance
    case serverError(_ error: NetworkError)
    case networkError(_ error: URLError)
    case responseError(_ error: Error)
    case unknownError(_ error: Error)
    case parseError(_ error: Error)
}

extension NetworkServiceError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Not connected to internet"
        case .invalidURL:
            return "URL provided is invalid"
        case .invalidResponse:
            return "Server response error"
        case .unauthenticated:
            return "You do not have access"
        case .notFound:
            return "Something went wrong!"
        case .serviceUnavailable:
            return "We are unable to process your request. Please retry or contact our customer support: 1800 2099 199"
        case .serverUnderMaintenance:
            return "Hi There, Toppr seems down for some maintenance. We will be back shortly. Sorry for the convenience caused."
        case .serverError(let error):
            return error.message ?? "Hi There, Toppr seems down for some maintenance. We will be back shortly. Sorry for the convenience caused."
        case .networkError(let error):
            return error.localizedDescription
        case .responseError(let error):
            return "Invalid response data! \(error.localizedDescription)"
        case .unknownError:
            return "Something went wrong"
        case .parseError:
            return "The expected response data is incorrect"
        }
    }
}

public struct NetworkError: Error {
    let statusCode: Int
    let status: String
    let message: String?
    public var rawResponse: JSON?
    
    public init(from json: JSON, httpStatusCode: Int) {
        rawResponse = json
        statusCode = json["status_code"].int ?? httpStatusCode
        status = json["status"].string ?? "FAILED"
        message = json["message"].string ?? json["error"].string ?? json["data"]["message"].string
    }
    
    public init(from error: Error) {
        statusCode = -9001
        status = error.localizedDescription
        message = error.localizedDescription
    }
    
    public init(statusCode: Int, status: String, message: String) {
        self.statusCode = statusCode
        self.status = status
        self.message = message
    }
}

