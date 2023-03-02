//
//  ASGalleryService.swift
//
//  Created by Vignesh A on 01/03/23
//  Copyright © 2021 . All rights reserved.
//


import SwiftyJSON
import Alamofire

class ASGalleryService {
    let networkManager: TPNetworkManager
    
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
}

extension ASGalleryService: FetchAstronomyPictureUseCase {

    func ASGalleryUseCase(completion: @escaping (Result<ASGalleryEntity, NetworkServiceError>) -> Void) {
        
        let request = FetchAstronomyPictureRequest(apiKey: "WT1XHdeQtkRlMpRCVgbdiSyQgqjoX8ZSyP7acqkG")
        let url = "https://api.nasa.gov/planetary/apod"        
        networkManager.callAPI(.get,
                               url: url,
                               parameters: request,
                               completionHandler: { (result: Result<ASGalleryResponse, NetworkServiceError>) in
            completion(result.map { data in
                return data.asDomain()
            })
        })
    }
}
