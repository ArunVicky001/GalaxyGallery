//
//  FetchAstronomyPictureRequest.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation

protocol FetchAstronomyPictureUseCase {
    func ASGalleryUseCase(completion: @escaping (Result<ASGalleryEntity, NetworkServiceError>) -> Void)
}
