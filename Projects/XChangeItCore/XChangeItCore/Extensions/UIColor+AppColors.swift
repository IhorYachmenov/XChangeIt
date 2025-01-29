//
//  UIColor+AppColors.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

// MARK: - For Color names used service https://www.htmlcsscolor.com/hex/F1F1F7
public extension UIColor {
    private static func loadColorFromBundleBundle(_ name: String) -> UIColor? {
        return UIColor(named: name, in: Bundle(for: AppColor.self), compatibleWith: nil)
    }
    
    class AppColor {
        public static let midnightExpressColor = loadColorFromBundleBundle("Midnight Express")
        public static let royalBlueColor = loadColorFromBundleBundle("Royal Blue")
        public static let waikawaGreyColor = loadColorFromBundleBundle("Waikawa Grey")
        public static let ghostWhiteColor = loadColorFromBundleBundle("Ghost White")
        public static let whiteColor = loadColorFromBundleBundle("App White")
        public static let hawkesBlue = loadColorFromBundleBundle("Hawkes Blue")
        public static let freeSpeechRed = loadColorFromBundleBundle("Free Speech Red")
    }
}
