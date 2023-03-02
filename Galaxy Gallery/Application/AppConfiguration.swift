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
            return "http://ec2-52-90-108-185.compute-1.amazonaws.com:8085"
        case .staging:
            return "http://ec2-52-90-108-185.compute-1.amazonaws.com:8085"
        case .preprod:
            return "http://ec2-52-90-108-185.compute-1.amazonaws.com:8085"
        }
    }
    
}
