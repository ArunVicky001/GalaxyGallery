//
//  AppCoordinator.swift
//  Galaxy Gallery
//
//  Created by Vignesh Arunagiri on 01/03/23.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    let serviceProvider = AppServiceProvider()
    
    lazy var rootViewController: UINavigationController = {
       let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
        
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() -> (Void) {
        HomeViewController()
    }
            
    func HomeViewController() {
        let sceneProvider = HomeSceneProvider(useCaseProvider: serviceProvider.makeHomeServiceProvider())
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController, sceneProvider: sceneProvider)
        homeCoordinator.start()
    }
}

