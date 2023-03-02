//
//  HomeGalleryViewModel.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation

class HomeGalleryViewModel {
        
    let useCase: FetchAstronomyPictureUseCase
    var reloadAstroPictureList = ObservableProperty(value: false)
    var astronomyPicture = ObservableProperty<ASGalleryEntity?>(value: nil)
    var error = ObservableProperty(value: false)
    
    init(useCase: FetchAstronomyPictureUseCase) {
        self.useCase = useCase
    }
    
    func viewLoad() {
        fetchAstroPicture()
    }
    
    func fetchAstroPicture() {
        useCase.ASGalleryUseCase() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.astronomyPicture.value = data
            case .failure(let error):
                print(error)
                self.error.value = true
            }
        }
    }
}
