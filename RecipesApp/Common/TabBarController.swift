//
//  TabBarController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    private let homeView = Builder.createHomeModule()
    private let searchView = Builder.createSearchModule()
    
    private lazy var favorites = UINavigationController(rootViewController: FavoritesViewController())
    
    private lazy var controllers: [UIViewController] = [
        favorites,
        UINavigationController(rootViewController: homeView),
        UINavigationController(rootViewController: searchView),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        setViewControllers(controllers, animated: false)
        setupTabBar()
        setupTabBarItemsImages()
        selectedIndex = 1
    }
}

extension TabBarController {
    private func setupTabBar() {
        
        let arrayOfTitles = ["Favorites", "Home", "Search" ]
        
        for counter in 0..<controllers.count {
            controllers[counter].title = arrayOfTitles[counter]
        }
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemGroupedBackground
    }
    
    private func setupTabBarItemsImages() {
        guard let items = tabBar.items else { return }
        
        let arrayOfSystemImages = ["star.circle", "house.circle", "magnifyingglass.circle" ]
        
        for counter in 0..<arrayOfSystemImages.count {
            items[counter].image = UIImage(systemName: arrayOfSystemImages[counter])
        }
    }
}
