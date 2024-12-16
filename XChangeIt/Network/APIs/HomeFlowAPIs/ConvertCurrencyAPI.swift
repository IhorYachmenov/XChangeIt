//
//  ConvertCurrencyAPI.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

enum ConvertCurrencyAPI {
    case convertCurrency(amount: String, source: String, target: String)
}

struct ConvertCurrencyAPITarget: APIRequestConfigurator {
    let api: ConvertCurrencyAPI
    
    init(api: ConvertCurrencyAPI) {
        self.api = api
    }
    
    var path: String {
        switch api {
        case .convertCurrency(amount: let amount, source: let source, target: let target):
            return "/currency/commercial/exchange/\(amount)-\(source)/\(target)/latest"
        }
    }
    
    var method: HTTPMethod {
        switch api {
        case .convertCurrency:
            return .get
        }
    }
    
    var headers: RequestHeaders? {
        switch api {
        case .convertCurrency:
            return nil
        }
    }
    
    var params: RequestParams? {
        switch api {
        case .convertCurrency:
            return nil
        }
    }
    
    var body: RequestBody? {
        switch api {
        case .convertCurrency:
            return nil
        }
    }
}
