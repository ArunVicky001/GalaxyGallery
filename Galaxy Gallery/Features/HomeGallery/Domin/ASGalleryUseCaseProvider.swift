//
//  HomeUseCaseProvider.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation

protocol ASGalleryUseCaseProvider {
    func fetchAstronomyPictureUseCase() -> FetchAstronomyPictureUseCase
}
