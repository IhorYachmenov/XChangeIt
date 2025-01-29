//
//  HomeConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import XChangeItHome

final class HomeConfigurator {
    class func initHomeVC(navigationDelegate: HomeVCNavigationDelegate) -> HomeViewController {
        let vc = HomeBuilder().build(navigationDelegate: navigationDelegate)
        return vc
    }
}
