//
//  ConvertCurrencyServiceMock.swift
//  XChangeItConvertCurrencyExample
//
//  Created by Ice on 29.01.2025.
//

import Foundation
import XChangeItConvertCurrency

final class ConvertCurrencyServiceMock: ConvertCurrencyServiceInterface {
    init() {}
    
    func convertCurrency(amount: String, sourceCurrency: String, targetCurrency: String) async throws -> ConvertCurrencyResponse {
        return ConvertCurrencyResponse(amount: String(Int.random(in: 1...1000)))
    }
}
