//
//  AppServiceProvider.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 05/05/22.
//

import Foundation

class AppServiceProvider {
           
    func makeHomeServiceProvider() -> HomeUseCaseProvider {
        let netWorkManager = TPNetworkManager(baseURL: AppConfiguration.baseURL)
        return HomeServiceProvider(networkManager: netWorkManager)
    }
    
}
