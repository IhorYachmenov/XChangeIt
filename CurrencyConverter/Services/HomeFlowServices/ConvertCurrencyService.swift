//
//  ConvertCurrencyService.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

final class ConvertCurrencyService: ConvertCurrencyServiceInterface {
    // TODO: Add network engine
    func convertCurrency(amount: String, currencyIdentifier: String) async throws -> ConvertCurrencyResponse {
        return ConvertCurrencyResponse(amount: "123123")
    }
}
