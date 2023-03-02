//
//  HomeCoordinator.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import UIKit
import Foundation

class HomeCoordinator: BaseCoordinator {
    let rootViewController: UINavigationController
    let sceneProvider: HomeSceneProvider
    
    init(rootViewController: UINavigationController,
         sceneProvider: HomeSceneProvider
        ) {
        self.rootViewController = rootViewController
        self.sceneProvider = sceneProvider
        
    }
    
    func start() {
        showHomePage()
    }    
    
    func showHomePage() {
        let controller = sceneProvider.makeHomeScene()
        rootViewController.setViewControllers([controller], animated: false)
    }
    
}
