//
//  HTTPClientConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public struct HTTPClientConfigurator {
    let baseURL: URL?
    let timeoutInterval: Double
    
    init(baseURL: String, timeoutInterval: TimeInterval = 60.0) {
        self.baseURL = URL(string: baseURL)
        self.timeoutInterval = timeoutInterval
    }
}
