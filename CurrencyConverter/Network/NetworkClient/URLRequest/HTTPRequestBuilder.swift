//
//  HTTPRequestBuilder.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

final class HTTPRequestBuilder {
    private let multipartBoundary: String = UUID().uuidString
    
    private let api: any APIRequestConfigurator
    private let body: RequestBody?
    
    init(api: any APIRequestConfigurator) {
        self.api = api
        self.body = api.body
    }
    
    private func requestURL(api: any APIRequestConfigurator) -> URL? {
        guard let url = HTTPClient.network.configurations?.baseURL else {
            return nil
        }
        
        var fullURL = url.appendingPathComponent(api.path)
        
        if let params = api.params {
            fullURL.append(queryItems: params.value.parameters)
        }
        
        return fullURL
    }
    
    private func requestTimeout(api: any APIRequestConfigurator) -> TimeInterval {
        guard let internalTimeout = api.timeoutInterval else {
            return HTTPClient.network.configurations?.timeoutInterval ?? 60.0
        }
        return internalTimeout
    }
    
    private func addUserAgent(to request: inout URLRequest) {
        let userAgent = "CurrencyConverter/\(Bundle.appVersion ?? "Uknown") (Build: \(Bundle.appBuild ?? "Uknown"); OSVersion: \(ProcessInfo.processInfo.operatingSystemVersionString))"
        request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
    }
    
    private func addHeaders(to request: inout URLRequest) {
        addUserAgent(to: &request)
        if let headers = api.headers {
            headers.value.headers.forEach({ request.addValue($0.value, forHTTPHeaderField: $0.key) })
        }
        if let body = body {
            let value = body.value.contentType(boundary: multipartBoundary)
            request.addValue(value.value, forHTTPHeaderField: value.key)
        }
    }
    
    private func addBody(to request: inout URLRequest) {
        if let body = body {
            request.httpBody = body.value.data(boundary: multipartBoundary)
        }
    }
    
    func prepareRequest() -> URLRequest? {
        guard let url = requestURL(api: api) else { return nil }
        var request = URLRequest(url: url, timeoutInterval: requestTimeout(api: api))
        
        request.httpMethod = api.method.rawValue
        addBody(to: &request)
        addHeaders(to: &request)
        
        return request
    }
}
