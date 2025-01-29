//
//  String+TextParsing.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

extension String {
    var charactersAfterDot: Int {
        if let dotIndex = self.firstIndex(of: ".") {
            let substringAfterDot = self[self.index(after: dotIndex)...]
            let charactersAfterDot = substringAfterDot.count
            return charactersAfterDot
        } else {
            return 0
        }
    }
    
    var containsDot: Bool {
        return self.contains(KeyboardButtonType.dot.symbol)
    }
    
    var firstZero: Bool {
        return self.first == DigitalKeyboardSymbols.zero.rawValue
    }
    
    var lastCharIsDot: Bool {
        guard let lastCharacter = self.last, lastCharacter == "." else { return false}
        return true
    }
}
