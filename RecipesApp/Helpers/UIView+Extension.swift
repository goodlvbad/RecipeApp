//
//  UIView+Extension.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 01.04.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
