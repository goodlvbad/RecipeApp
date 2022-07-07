//
//  SplashViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 07.07.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let imageName = "logo"
    private let widthConst = 150
    
    lazy var logoImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: widthConst, height: widthConst))
        view.image = UIImage(named: imageName)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.center = view.center
    }
}
