//
//  UIView+Animation.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration: CFTimeInterval = 0.3) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
