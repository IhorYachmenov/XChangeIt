//
//  ConvertCurrencyService.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

final class ConvertCurrencyService: ConvertCurrencyServiceInterface {
    
    deinit {
        print(#function, "ConvertCurrencyService")
    }
    // TODO: Add network engine
    func convertCurrency(amount: String, sourceCurrency: String, targetCurrency: String) async throws -> ConvertCurrencyResponse {
        print(#function)
        try await Task.sleep(nanoseconds: 7 * 1_000_000_000)
        return ConvertCurrencyResponse(amount: "123123")
    }
}
