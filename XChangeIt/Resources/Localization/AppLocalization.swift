//
//  AppLocalization.swift
//  XChangeIt
//
//  Created by Ice on 18.12.2024.
//

import Foundation

enum AppLocalizedTables: String {
    case homeScreen = "HomeScreenLocalizable"
    case convertCurrencyScreen = "ConvertCurrencyScreenLocalizable"
    case comon = "Common"
}

struct AppLocalization {
    struct Common {
        static let cancel = String.localizable(key: "Cancel", table: .comon)
    }
    struct HomeScreen {
        static let nextScreenButton = String.localizable(key: "Next Screen Button", table: .homeScreen)
    }
    struct ConvertCurrencyScreen {
        static let title = String.localizable(key: "Screen Title", table: .convertCurrencyScreen)
        static let youConvert = String.localizable(key: "You Convert", table: .convertCurrencyScreen)
        static let youReceive = String.localizable(key: "You Receive", table: .convertCurrencyScreen)
        static let quantity = String.localizable(key: "Quantity", table: .convertCurrencyScreen)
        static let convert = String.localizable(key: "Convert", table: .convertCurrencyScreen)
        static let from = String.localizable(key: "From", table: .convertCurrencyScreen)
        static let to = String.localizable(key: "To", table: .convertCurrencyScreen)
        static let sheetTitle = String.localizable(key: "Sheet Title", table: .convertCurrencyScreen)
    }
}
