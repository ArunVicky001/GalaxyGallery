//
//  BaseCoordinator.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import UIKit

protocol BaseCoordinator {
//    func start()
    var rootViewController: UINavigationController { get }
}

extension BaseCoordinator {
    func setRootController(controller: UIViewController, animated: Bool = true) {
        rootViewController.setViewControllers([controller], animated: animated)
    }

    func present(controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        rootViewController.present(controller, animated: animated, completion: completion)
    }
    
    func push(controller: UIViewController, animated: Bool = true) {
        rootViewController.pushViewController(controller, animated: animated)
    }
    
    func dismissPresented(animated: Bool = false, completion: (() -> Void)? = nil) {
        if let controller = rootViewController.presentedViewController {
            controller.dismiss(animated: animated, completion: completion)
        } else {
            completion?()
        }
    }
    
    func dismissAndPopToRootView(animated: Bool = false, completion: (() -> Void)? = nil) {
        rootViewController.popToRootViewController(animated: animated)
        dismissPresented(animated: animated, completion: completion)
    }
    
}


