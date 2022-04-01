//
//  AppDelegate.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let homeView = Builder.createHomeModule()
//        window?.rootViewController = UINavigationController(rootViewController: homeView)
//        window?.rootViewController = homeView
        
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        return true
    }
    
}

