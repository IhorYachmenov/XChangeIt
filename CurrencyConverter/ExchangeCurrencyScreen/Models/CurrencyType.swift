//
//  CurrencyType.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

enum CurrencyType {
    case unitedStatesDollar
    case euro
    case britishPound
    case japaneseYen
    case swissFranc
    case australianDollar
    case canadianDollar
    case swedishKrona
    case polishZloty
    
    var description: (name: String, code: String) {
        return switch self {
        case .unitedStatesDollar:
            ("United States Dollar", "USD")
        case .euro:
            ("Euro", "EUR")
        case .britishPound:
            ("British Pound", "GBP")
        case .japaneseYen:
            ("Japanese Yen", "JPY")
        case .swissFranc:
            ("Swiss Franc", "CHF")
        case .australianDollar:
            ("Australian Dollar", "AUD")
        case .canadianDollar:
            ("Canadian Dollar", "CAD")
        case .swedishKrona:
            ("Swedish Krona", "SEK")
        case .polishZloty:
            ("Polish Zloty", "PLN")
        }
    }
    
    var image: (circle: UIImage?, square: UIImage?) {
        return switch self {
        case .unitedStatesDollar:
            (img("USAFlagCircle"), img("USAFlagSquare"))
        case .euro:
            (img("EuropeFlagCircle"), img("EuropeFlagSquare"))
        case .britishPound:
            (img("UniderKingdomFlagCircle"), img("UniderKingdomFlagSquare"))
        case .japaneseYen:
            (img("JapanFlagCircle"), img("JapanFlagSquare"))
        case .swissFranc:
            (img("SwitzerlandFlagCircle"), img("SwitzerlandFlagSquare"))
        case .australianDollar:
            (img("AustraliaFlagCircle"), img("AustraliaFlagSquare"))
        case .canadianDollar:
            (img("CanadaFlagCircle"), img("CanadaFlagSquare"))
        case .swedishKrona:
            (img("SwedenFlagCircle"), img("SwedenFlagSquare"))
        case .polishZloty:
            (img("PolandFlagCircle"), img("PolandFlagSquare"))
        }
    }
    
    private func img(_ name: String) -> UIImage? {
        return UIImage(named: name)
    }
}
