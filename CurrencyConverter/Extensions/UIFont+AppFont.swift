//
//  UIFont+Custom.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

enum AppFontType: String {
    case regular = "ReadexPro-Regular"
    case medium = "ReadexPro-Medium"
    case bold = "ReadexPro-Bold"
    case semiBold = "ReadexPro-SemiBold"
    case light = "ReadexPro-Light"
    case extraLight = "ReadexPro-ExtraLight"
    case variable = "ReadexPro-Variable"
}

extension UIFont {
    static func appFont(type: AppFontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: 13)
    }
}
