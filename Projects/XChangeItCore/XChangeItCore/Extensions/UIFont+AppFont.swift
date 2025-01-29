//
//  UIFont+Custom.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

public enum AppFontType: String {
    case regular = "ReadexPro-Regular"
    case medium = "ReadexPro-Medium"
    case bold = "ReadexPro-Bold"
    case semiBold = "ReadexPro-SemiBold"
    case light = "ReadexPro-Light"
    case extraLight = "ReadexPro-ExtraLight"
    case variable = "ReadexPro-Variable"
}

public extension UIFont {
    static func appFont(type: AppFontType, size: CGFloat) -> UIFont {
        if let fontURL = Bundle(for: FontClass.self).url(forResource: type.rawValue, withExtension: "ttf"),
           let fontData = try? Data(contentsOf: fontURL) {
            return registerAndUseFont(from: fontData, size: size, fontName: type.rawValue)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

// MARK: Logic for dynamic font loading
fileprivate class FontClass: NSObject {}
fileprivate extension UIFont {
    private static var registeredFonts: [String] = []
    
    private static func registerAndUseFont(from fontData: Data, size: CGFloat, fontName: String) -> UIFont {
        guard !registeredFonts.contains(fontName) else {
            return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        var error: Unmanaged<CFError>?
        
        guard let provider = CGDataProvider(data: fontData as CFData),
              let loadedFont = CGFont(provider) else {
            return UIFont.systemFont(ofSize: size)
        }
        
        guard CTFontManagerRegisterGraphicsFont(loadedFont, &error) else {
            guard let _ = error else {
                return UIFont.systemFont(ofSize: size)
            }
            return UIFont.systemFont(ofSize: size)
        }

        let loadedFontName = loadedFont.postScriptName as String? ?? "FallbackFont"
        
        guard let uiFont = UIFont(name: loadedFontName, size: size) else {
            print("Failed to create UIFont with the loaded font.")
            return UIFont.systemFont(ofSize: size)
        }
        registeredFonts.append(uiFont.fontName)
        return uiFont
    }
}
