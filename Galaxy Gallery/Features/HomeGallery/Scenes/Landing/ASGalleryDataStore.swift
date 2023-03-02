//
//  ASGalleryDataStore.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 02/03/23.
//

import Foundation

class ASGalleryDataStore {
    static let shared = ASGalleryDataStore()
    private let userDefaults = UserDefaults.standard
    
    // Store the response data.
    func saveData(data: ASGalleryEntity) {
        let encoder = JSONEncoder()
        let galleryEntity = GalleryEntity(from: data)
        if let encoded = try? encoder.encode(galleryEntity) {
            userDefaults.set(encoded, forKey: "gallery_entity")
        }
    }
    
    // Retrieve the stored response data.
    func getStoredData() -> GalleryEntity? {
        if let data = UserDefaults.standard.data(forKey: "gallery_entity") {
            // decode the data as an instance of the struct
            let decoder = JSONDecoder()
            if let entity = try? decoder.decode(GalleryEntity.self, from: data) {
                return entity
            }
        }
        return nil
    }
       
}
