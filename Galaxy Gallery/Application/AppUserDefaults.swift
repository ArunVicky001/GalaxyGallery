//
//  AppUserDefaults.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 27/05/22.
//

import Foundation

class AppUserDefaults {
    private static let schoolOSDefaultkey = "com.Chef.app"

    struct Keys {
        static let loginSesion = "login_session"
    }
    
    static let shared = AppUserDefaults()
    let defaults = UserDefaults.standard
        
    var loginSesion: Bool? {
        get { return defaults.bool(forKey: Keys.loginSesion) }
        set {
            defaults.set(newValue, forKey: Keys.loginSesion)
            defaults.synchronize()
        }
    }
}

//MARK: - Clear Data
extension AppUserDefaults {
    func removeAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
            defaults.synchronize()
        }
    }
}

