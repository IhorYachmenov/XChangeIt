//
//  UIView+Shadow.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

public extension UIView {
    func makeShadow(color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat, viewCornerRadius: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            self?.layer.shadowColor = color
            self?.layer.shadowOpacity = opacity
            self?.layer.shadowOffset = offset
            self?.layer.shadowRadius = radius
            
            self?.layer.shouldRasterize = true
            self?.layer.rasterizationScale = UIScreen.main.scale
            
            guard let bounds = self?.bounds else { return }
            self?.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius).cgPath
        }
    }
}
