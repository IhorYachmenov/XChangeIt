//
//  HTTPRequestMaker.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

final class HTTPRequestMaker {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func performRequest<Response: Decodable>(api: any APIRequestConfigurator) async throws -> Response {
        do {
            guard let request = HTTPRequestBuilder(api: api).prepareRequest() else {
                throw NetworkingError.requestFailed(innerError: URLError(.badURL))
            }
            
            #if DEBUG
            print("!!!Request", request)
            #else
            #endif
            
            let (data, response) = try await urlSession.data(for: request)
            
            guard let _ = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkingError.invalidStatusCode(statusCode: -1)
            }
            
            return try await HTTPResponseHandler().handleRequestResponse(response: response, data: data)
            
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.otherError(innerError: error)
        }
    }
}
