//
//  ConvertCurrencyConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation
import XChangeItConvertCurrency

final class ConvertCurrencyConfigurator {
    class func initializeConvertCurrencyVC(navigationDelegate: ConvertCurrencyVCNavigationDelegate, httpClient: HTTPClientAPI) -> ConvertCurrencyViewController {
        let service = ConvertCurrencyService(httpClient: httpClient)
        let viewModel = ConvertCurrencyViewModel(service: service)
        let vc = ConvertCurrencyViewController()
        vc.navigationDelegate = navigationDelegate
        vc.viewModel = viewModel
        return vc
    }
}
