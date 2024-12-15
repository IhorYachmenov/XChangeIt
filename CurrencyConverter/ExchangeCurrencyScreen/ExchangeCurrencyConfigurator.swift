//
//  ExchangeCurrencyConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

final class ExchangeCurrencyConfigurator {
    class func initializeExchangeCurrencyVC(navigationDelegate: ExchangeCurrencyVCNavigationDelegate) -> ExchangeCurrencyViewController {
//        let service = ClockInClockOutListDataService()
//        let viewModel = EchangeCurrencyViewModel(service: service)
        let viewModel = EchangeCurrencyViewModel()
        let vc = ExchangeCurrencyViewController()
        vc.navigationDelegate = navigationDelegate
        vc.viewModel = viewModel
        return vc
    }
}
