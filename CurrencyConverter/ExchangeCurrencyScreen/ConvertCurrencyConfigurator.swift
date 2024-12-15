//
//  ConvertCurrencyConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

final class ConvertCurrencyConfigurator {
    class func initializeConvertCurrencyVC(navigationDelegate: ConvertCurrencyVCNavigationDelegate) -> ConvertCurrencyViewController {
//        let service = ClockInClockOutListDataService()
//        let viewModel = EchangeCurrencyViewModel(service: service)
        let viewModel = ConvertCurrencyViewModel()
        let vc = ConvertCurrencyViewController()
        vc.navigationDelegate = navigationDelegate
        vc.viewModel = viewModel
        return vc
    }
}
