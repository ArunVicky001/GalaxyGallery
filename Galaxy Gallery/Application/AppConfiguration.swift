//
//  AppConfiguration.swift
//  Galaxy Gallery
//
//  Created by Vignesh Arunagiri on 01/03/23.
//

import Foundation

struct AppConfiguration {
    
    enum Environment: String {
        case production, staging, preprod
    }
    
    static let environment = Environment(rawValue: "preprod")!
    
    static var baseURL: String {
        switch AppConfiguration.environment {
        case .production:
            return "https://api.nasa.gov/planetary/"
        case .staging:
            return "https://api.nasa.gov/planetary/"
        case .preprod:
            return "https://api.nasa.gov/planetary/"
        }
    }
    
}
