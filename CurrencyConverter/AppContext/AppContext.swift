//
//  AppContext.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import UIKit

final class AppContext: NSObject {
    let appCoordinator: MainFlowCoordinator
    
    override init() {
        self.appCoordinator = MainFlowCoordinator()
    }
}
