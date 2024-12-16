//
//  HTTPClientAPI.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public protocol HTTPClientAPI: AnyObject {
    func performRequest<Response: Decodable>(api: any APIRequestConfigurator) async throws -> Response
}
