//
//  SplashPresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 07.07.2022.
//

import UIKit

protocol SplashPresenterProtocol: AnyObject {
    func present()
    func dismiss(completion: @escaping () -> Void)
}

final class SplashPresenter: SplashPresenterProtocol {
    
    private lazy var animator: SplashAnimatorProtocol = SplashAnimator(foregroundSplashWindow: foregroundSplashWindow)
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashViewController = SplashViewController()
        let splashWindow = self.splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)
        return splashWindow
    }()
    
    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
        let splashWindow = UIWindow(frame: UIScreen.main.bounds)
        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController
        return splashWindow
    }
    
    func present() {
        animator.animateAppearance()
    }
    
    func dismiss(completion: @escaping () -> Void) {
        animator.animateDisappearance(completion: completion)
    }
}
