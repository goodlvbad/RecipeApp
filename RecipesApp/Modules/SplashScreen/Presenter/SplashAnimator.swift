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
        
        let delay1: TimeInterval = 0.8
        let delay2: TimeInterval = delay1 + 0.5
        let delay3: TimeInterval = delay2 + 0.25
        let delay4: TimeInterval = delay3 + 0.2
        
        UIView.animate(withDuration: 0.6) {
            self.foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        } completion: { isEnded in
            if isEnded {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay1) {
                    self.foregroundSplashViewController.setLogoImage(num: 1)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + delay2) {
                    self.foregroundSplashViewController.setLogoImage(num: 2)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + delay3) {
                    self.foregroundSplashViewController.setLogoImage(num: 3)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + delay4) {
                    self.foregroundSplashViewController.logoImageView.alpha = 0
                }
            }
        }
    }
    
    func animateDisappearance(completion: @escaping () -> Void) {
        foregroundSplashWindow.alpha = 0
    }
}
