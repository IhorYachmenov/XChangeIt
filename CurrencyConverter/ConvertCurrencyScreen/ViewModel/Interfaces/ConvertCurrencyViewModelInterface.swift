//
//  EchangeCurrencyViewModelInterface.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
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
    
    var description: (name: String, code: String, sign: String) {
        return switch self {
        case .unitedStatesDollar:
            ("United States Dollar", "USD", "$")
        case .euro:
            ("Euro", "EUR", "€")
        case .britishPound:
            ("British Pound", "GBP", "£")
        case .japaneseYen:
            ("Japanese Yen", "JPY", "¥")
        case .swissFranc:
            ("Swiss Franc", "CHF", "SFr.")
        case .australianDollar:
            ("Australian Dollar", "AUD", "$A")
        case .canadianDollar:
            ("Canadian Dollar", "CAD", "$C")
        case .swedishKrona:
            ("Swedish Krona", "SEK", "kr")
        case .polishZloty:
            ("Polish Zloty", "PLN", "zł")
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
    
    static let listOfAll: [CurrencyType] = [
        CurrencyType.unitedStatesDollar,
        CurrencyType.euro,
        CurrencyType.britishPound,
        CurrencyType.japaneseYen,
        CurrencyType.swissFranc,
        CurrencyType.australianDollar,
        CurrencyType.canadianDollar,
        CurrencyType.swedishKrona,
        CurrencyType.polishZloty
    ]
}

protocol ConvertCurrencyViewModelInterface: AnyObject {
    var observeKeyboardInputChanges: ((Result<String, Error>) -> ())? { get set }
    // TODO:  String is test solution
    var observeConvertedData: ((Result<String, Error>) -> ())? { get set }
    
    func handleKeyboardInput(symbol: KeyboardButtonType)
    func updateCurrenciesTypes(source: CurrencyType, target: CurrencyType)
}
