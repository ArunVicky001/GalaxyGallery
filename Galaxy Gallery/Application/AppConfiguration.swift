//
//  AppConfiguration.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 05/05/22.
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
