//
//  DigitalKeyboardSymbols.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

public enum DigitalKeyboardSymbols: Character {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    
    public var string: String {
        return String(self.rawValue)
    }
}
