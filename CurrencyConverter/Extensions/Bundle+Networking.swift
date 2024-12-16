//
//  Bundle+Networking.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public extension Bundle {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
