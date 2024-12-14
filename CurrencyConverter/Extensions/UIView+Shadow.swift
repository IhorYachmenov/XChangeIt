//
//  UIView+Shadow.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

extension UIView {
    func makeShadow(color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            self?.layer.shadowColor = color
            self?.layer.shadowOpacity = opacity
            self?.layer.shadowOffset = offset
            self?.layer.shadowRadius = radius
            
            self?.layer.shouldRasterize = true
            self?.layer.rasterizationScale = UIScreen.main.scale
            
            guard let bounds = self?.bounds else { return }
            self?.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            
        }
        
    }
}
