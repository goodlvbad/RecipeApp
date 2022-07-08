//
//  SplashViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 07.07.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let logoImageName = "logo"
    private let logoBackImageName = "logoBackground"
    
    private let widthConst: CGFloat = 150
    
    lazy var logoImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: widthConst, height: widthConst))
        view.image = UIImage(named: logoImageName)
        return view
    }()
    
    lazy var logoBackImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.image = UIImage(named: logoBackImageName)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews([
            logoBackImageView,
            logoImageView
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.center = view.center
    }
    
    func setLogoImage(num: Int) {
        let imageStr = logoImageName + "\(num)"
        logoImageView.image = UIImage(named: imageStr)
    }
    
}
