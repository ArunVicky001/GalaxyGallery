//
//  AppServiceProvider.swift
//  Galaxy Gallery
//
//  Created by Vignesh Arunagiri on 01/03/23.
//

import Foundation

class AppServiceProvider {
           
    func makeHomeServiceProvider() -> HomeUseCaseProvider {
        let netWorkManager = TPNetworkManager(baseURL: AppConfiguration.baseURL)
        return HomeServiceProvider(networkManager: netWorkManager)
    }
    
}
