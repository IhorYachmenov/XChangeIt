//
//  NetworkingError.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

enum NetworkingError: Error {
    case encodingFailed(innerError: EncodingError)
    case decodingFailed(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)
    case clientError(error: String, statusCode: HTTPStatusCode)
    case serverError(error: String, statusCode: HTTPStatusCode)
    case unknown
    case loginRequired
}
