//
//  HTTPRequestBuilder.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}

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
            if #available(iOS 16.0, *) {
                fullURL.append(queryItems: params.value.parameters)
            } else {
                guard var urlComps = URLComponents(string: fullURL.absoluteString) else { return fullURL }
                urlComps.queryItems = params.value.parameters
                guard var url = URLComponents(string: fullURL.absoluteString)?.url else { return fullURL }
                fullURL = url
            }
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
