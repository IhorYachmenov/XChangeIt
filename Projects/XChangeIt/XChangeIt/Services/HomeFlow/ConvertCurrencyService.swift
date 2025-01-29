//
//  ConvertCurrencyService.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation
import XChangeItConvertCurrency

final class ConvertCurrencyService: ConvertCurrencyServiceInterface {
    let httpClient: HTTPClientAPI
    
    let api: (ConvertCurrencyAPI) -> ConvertCurrencyAPITarget
    
    init(httpClient: HTTPClientAPI) {
        self.httpClient = httpClient
        self.api = apiCreator()
    }
    
    func convertCurrency(amount: String, sourceCurrency: String, targetCurrency: String) async throws -> ConvertCurrencyResponse {
        let convertCorrencyApi = api(.convertCurrency(amount: amount, source: sourceCurrency, target: targetCurrency))
        let request: ConvertCurrencyResponseDTO = try await httpClient.performRequest(api: convertCorrencyApi)
        
        return convertCurrencyDataModelFromDTO(request)
    }
}

fileprivate func apiCreator() -> (_ api: ConvertCurrencyAPI) -> ConvertCurrencyAPITarget {
    return { api in
        return ConvertCurrencyAPITarget(api: api)
    }
}
