//
//  ConvertCurrencyResponse.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public struct ConvertCurrencyResponse {
    public let amount: String
    
    public init(amount: String) {
        self.amount = amount
    }
}
