//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import UIKit

final class MainFlowCoordinator {
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func runFlow() {
        let vc = HomeConfigurator.initializeHomeVC(navigationDelegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func openCurrencyConverterScreen() {
        let vc = ExchangeCurrencyConfigurator.initializeExchangeCurrencyVC(navigationDelegate: self)
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
extension MainFlowCoordinator: ExchangeCurrencyVCNavigationDelegate {
    func closeScreen() {
        navigationController.popViewController(animated: true)
    }
}

