//
//  ConvertCurrencyConfigurator.swift
//  XChangeItConvertCurrency
//
//  Created by Ice on 29.01.2025.
//

public final class ConvertCurrencyBuilder {
    public init() {}
    
    public  func build(navigationDelegate: ConvertCurrencyVCNavigationDelegate?, service: ConvertCurrencyServiceInterface) -> ConvertCurrencyViewController {
        let viewModel = ConvertCurrencyViewModel(service: service)
        let vc = ConvertCurrencyViewController()
        vc.navigationDelegate = navigationDelegate
        vc.viewModel = viewModel
        return vc
    }
}
