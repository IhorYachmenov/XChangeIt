//
//  HomeConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import XChangeItHome

final class HomeConfigurator {
    class func initializeHomeVC(navigationDelegate: HomeVCNavigationDelegate) -> HomeViewController {
        let vc = HomeViewController()
        vc.navigationDelegate = navigationDelegate
        return vc
    }
}
