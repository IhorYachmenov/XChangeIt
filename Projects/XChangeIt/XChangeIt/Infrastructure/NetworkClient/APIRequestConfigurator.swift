//
//  APIRequestConfigurator.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public protocol APIRequestConfigurator {
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The headers to be used in the request.
    var headers: RequestHeaders? { get }
    
    /// The params to be used in the request.
    var params: RequestParams? { get }
    
    /// The body to be used in the request.
    var body: RequestBody? { get }
    
    var timeoutInterval: TimeInterval? { get }
}

public extension APIRequestConfigurator {
    var timeoutInterval: TimeInterval? {
        return nil
    }
}
