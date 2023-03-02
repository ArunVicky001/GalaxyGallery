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
    
    // Store the response data
    func saveAPODData(data: ASGalleryEntity) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults.set(encoded, forKey: "apod_data")
        }
    }
    
    // Retrieve the stored response data
    func getStoredAPODData() -> ASGalleryEntity? {
        guard let data = userDefaults.object(forKey: "apod_data") as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(ASGalleryEntity.self, from: data) {
            return decoded
        }
        
        return nil
    }
    
    // Store the image data
    func saveImageData(data: Data) {
        userDefaults.set(data, forKey: "asGallery_image")
    }
    
    // Retrieve the stored image data
    func getStoredImageData() -> Data? {
        return userDefaults.data(forKey: "asGallery_image")
    }       
}
