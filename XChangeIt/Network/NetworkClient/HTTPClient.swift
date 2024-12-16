//
//  HTTPClient.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public final class HTTPClient: @unchecked Sendable, HTTPClientAPI {
    private(set) var configurations: HTTPClientConfigurator?
    
    private let requestMaker: HTTPRequestMaker
    private let urlSession: URLSession

    public static let network = HTTPClient()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        urlSession = URLSession.init(configuration: configuration, delegate: nil, delegateQueue: nil)
        requestMaker = HTTPRequestMaker(urlSession: urlSession)
    }
    
    public func initConfigurations(_ configurations: HTTPClientConfigurator) {
        self.configurations = configurations
    }
    
    public func performRequest<Response: Decodable>(api: any APIRequestConfigurator) async throws -> Response {
        do {
            let response: Response = try await requestMaker.performRequest(api: api)
            return response
        } catch let error as DecodingError {
            throw NetworkingError.decodingFailed(innerError: error)
        } catch let error as EncodingError {
            throw NetworkingError.encodingFailed(innerError: error)
        } catch let error as URLError {
            throw NetworkingError.requestFailed(innerError: error)
        } catch let error as NetworkingError {
           throw error
        } catch {
            throw NetworkingError.otherError(innerError: error)
        }
    }
}
