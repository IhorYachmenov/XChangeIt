//
//  AppLocalization.swift
//  XChangeIt
//
//  Created by Ice on 18.12.2024.
//

import Foundation

public enum AppLocalizedTables: String {
    case homeScreen = "HomeScreenLocalizable"
    case convertCurrencyScreen = "ConvertCurrencyScreenLocalizable"
    case comon = "Common"
}

public class AppLocalization {
    public struct Common {
        public static let cancel = String.localizable(key: "Cancel", table: .comon)
    }
    public struct HomeScreen {
        public static let nextScreenButton = String.localizable(key: "Next Screen Button", table: .homeScreen)
    }
    public struct ConvertCurrencyScreen {
        public static let title = String.localizable(key: "Screen Title", table: .convertCurrencyScreen)
        public static let youConvert = String.localizable(key: "You Convert", table: .convertCurrencyScreen)
        public static let youReceive = String.localizable(key: "You Receive", table: .convertCurrencyScreen)
        public static let quantity = String.localizable(key: "Quantity", table: .convertCurrencyScreen)
        public static let convert = String.localizable(key: "Convert", table: .convertCurrencyScreen)
        public static let from = String.localizable(key: "From", table: .convertCurrencyScreen)
        public static let to = String.localizable(key: "To", table: .convertCurrencyScreen)
        public static let sheetTitle = String.localizable(key: "Sheet Title", table: .convertCurrencyScreen)
    }
}
