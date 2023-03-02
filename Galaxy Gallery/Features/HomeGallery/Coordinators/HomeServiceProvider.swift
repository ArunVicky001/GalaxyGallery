//
//  ServiceProvider.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation

class HomeServiceProvider: HomeUseCaseProvider {
    
    let networkManager: TPNetworkManager
    
    init(networkManager: TPNetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchAstronomyPictureUseCase() -> FetchAstronomyPictureUseCase {
        return ASGalleryService(networkManager: networkManager)
    }
    
}

