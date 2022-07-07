//
//  SplashAnimator.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 07.07.2022.
//

import UIKit

protocol SplashAnimatorProtocol: AnyObject {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorProtocol {
    
    private unowned let foregroundSplashWindow: UIWindow
    private unowned let foregroundSplashViewController: SplashViewController

    init(foregroundSplashWindow: UIWindow) {
        self.foregroundSplashWindow = foregroundSplashWindow
        guard let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController else {
            fatalError("Splash window doesn't have splash root view controller!")
        }
        self.foregroundSplashViewController = foregroundSplashViewController
    }
    
    func animateAppearance() {
        foregroundSplashWindow.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.foregroundSplashViewController.logoImageView.alpha = 0
        })
    }
    
    func animateDisappearance(completion: @escaping () -> Void) {
        foregroundSplashWindow.alpha = 0
    }
}
