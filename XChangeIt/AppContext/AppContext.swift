//
//  AppContext.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import UIKit
// MARK: - Monolit
struct AppEnvironment {
    static let baseURL: String = "http://api.evp.lt"
}

final class AppContext: NSObject {
    let appCoordinator: MainFlowCoordinator
    
    override init() {
        HTTPClient.network.initConfigurations(HTTPClientConfigurator(baseURL: AppEnvironment.baseURL))
        self.appCoordinator = MainFlowCoordinator(httpClient: HTTPClient.network)
    }
}
