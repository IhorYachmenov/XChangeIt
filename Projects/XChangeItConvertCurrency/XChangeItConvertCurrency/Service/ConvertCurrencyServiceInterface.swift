//
//  ConvertCurrencyService.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public protocol ConvertCurrencyServiceInterface: AnyObject {
    func convertCurrency(amount: String, sourceCurrency: String, targetCurrency: String) async throws -> ConvertCurrencyResponse
}
