//
//  UIApplication+Inset.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

public extension UIApplication {
    static var windowInset: UIEdgeInsets {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let safeAreaInsets = window?.safeAreaInsets
        
        guard let inset = safeAreaInsets else { return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        
        return UIEdgeInsets(top: inset.top, left: inset.left, bottom: inset.bottom, right: inset.right)
    }
}
