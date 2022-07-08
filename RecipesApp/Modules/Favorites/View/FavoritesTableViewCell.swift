//
//  FavoritesTableViewCell.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 10.04.2022.
//

import Foundation
import UIKit

final class FavoritesTableViewCell: UITableViewCell {

    private let cornerRadius: CGFloat = 18
    
    private lazy var recipeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var recipeReadyTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(titile: String?, image: UIImage?, ready: String?) {
        recipeTitle.text = titile
        recipeImageView.image = image
        if let ready = ready {
            recipeReadyTime.text = "Ready in minutes: " + ready
        }
    }
}

extension FavoritesTableViewCell {
    private func setupView() {
        contentView.backgroundColor = .clear
        contentView.addSubviews([
            recipeTitle,
            recipeImageView,
            recipeReadyTime,
        ])
        
        NSLayoutConstraint.activate([
            recipeTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            recipeImageView.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            recipeImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            
            recipeReadyTime.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            recipeReadyTime.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            recipeReadyTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeReadyTime.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}
