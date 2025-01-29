//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import UIKit
import XChangeItHome
import XChangeItConvertCurrency

final class MainFlowCoordinator {
    let navigationController: UINavigationController
    let httpClient: HTTPClientAPI
    
    init(httpClient: HTTPClientAPI) {
        self.navigationController = UINavigationController()
        self.httpClient = httpClient
    }
    
    func runFlow() {
        let vc = HomeConfigurator.initHomeVC(navigationDelegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func openCurrencyConverterScreen() {
        let vc = ConvertCurrencyConfigurator.initConvertCurrencyVC(navigationDelegate: self, httpClient: httpClient)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - Home Screen
extension MainFlowCoordinator: HomeVCNavigationDelegate {
    func openCurrencyConverveterScreen() {
        openCurrencyConverterScreen()
    }
}

// MARK: - Convert Currency Screen
extension MainFlowCoordinator: ConvertCurrencyVCNavigationDelegate {
    func closeScreen() {
        navigationController.popViewController(animated: true)
    }
}

