//
//  TabBarController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    private let favoritesView = Builder.createFavoritesModule()
    private let searchView = Builder.createSearchModule()
    
    private lazy var controllers: [UIViewController] = [
        UINavigationController(rootViewController: favoritesView),
        UINavigationController(rootViewController: searchView),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
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
        
        let arrayOfTitles = ["Favorites",
                             "Search" ]
        
        for counter in 0..<controllers.count {
            controllers[counter].title = arrayOfTitles[counter]
        }
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemGroupedBackground
    }
    
    private func setupTabBarItemsImages() {
        guard let items = tabBar.items else { return }
        
        let arrayOfSystemImages = ["star.circle",
                                   "magnifyingglass.circle" ]
        
        for counter in 0..<arrayOfSystemImages.count {
            items[counter].image = UIImage(systemName: arrayOfSystemImages[counter])
        }
    }
}
