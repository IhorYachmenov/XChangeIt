//
//  HTTPResponseHandler.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation
import XChangeItCore

final class HTTPResponseHandler {
    func handleRequestResponse<Response: Decodable>(response: URLResponse, data: Data) async throws -> Response {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: -1)
        }
        
        if statusCode.isSuccess {
            return try await parseResponse(data: data)
        }
        
        if statusCode.isClientError {
            let errors: HTTPClientDefaultError = try await parseResponse(data: data)
            let errorDescription: String = errors.description ?? "Can't Read Error Message"
            throw NetworkingError.clientError(error: errorDescription, statusCode: statusCode)
        }
        
        if statusCode.isServerError {
            let errors: HTTPClientDefaultError = try await parseResponse(data: data)
            let errorDescription: String = errors.description ?? "Can't Read Error Message"
            throw NetworkingError.serverError(error: errorDescription, statusCode: statusCode)
        }
        
        throw NetworkingError.unknown
    }
    
    func parseResponse<Response: Decodable>(data: Data) async throws -> Response {
        do {
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
}
