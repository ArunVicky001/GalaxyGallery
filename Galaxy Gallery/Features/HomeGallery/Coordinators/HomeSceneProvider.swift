//
//  HomeSceneProvider.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation
import UIKit

class HomeSceneProvider {
    
    let useCaseProvider: HomeUseCaseProvider

    init(useCaseProvider: HomeUseCaseProvider) {
        self.useCaseProvider = useCaseProvider
    }
        
    func makeHomeScene() -> HomeGalleryViewController {
        let viewModel = HomeGalleryViewModel(useCase: useCaseProvider.fetchAstronomyPictureUseCase())
        let controller = HomeGalleryViewController(viewModel: viewModel)
        return controller
    }
               
}

