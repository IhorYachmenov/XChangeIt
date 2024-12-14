//
//  UIView+Shadow.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

extension UIView {
    func makeShadow(color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
