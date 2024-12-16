//
//  UIImageView+Animation.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

extension UIImageView {
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
