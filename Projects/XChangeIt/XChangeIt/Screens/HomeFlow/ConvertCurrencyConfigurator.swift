//
//  ConvertCurrencyConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import XChangeItConvertCurrency

final class ConvertCurrencyConfigurator {
    class func initConvertCurrencyVC(navigationDelegate: ConvertCurrencyVCNavigationDelegate, httpClient: HTTPClientAPI) -> ConvertCurrencyViewController {
        let service = ConvertCurrencyService(httpClient: httpClient)
        let viewModel = ConvertCurrencyViewModel(service: service)
        let vc = ConvertCurrencyBuilder().build(navigationDelegate: navigationDelegate, service: service)
        vc.viewModel = viewModel
        return vc
    }
}
