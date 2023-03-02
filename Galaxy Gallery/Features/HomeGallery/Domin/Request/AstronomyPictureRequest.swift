//
//  AstronomyPictureRequest.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import Foundation

struct FetchAstronomyPictureRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
    
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(apiKey, forKey: .apiKey)
    }
}
