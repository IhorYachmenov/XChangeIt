//
//  NetworkingError.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

fileprivate struct Styles {
    struct Text {
        static let encodingError = "Encoding Error"
        static let decodingError = "Invalid Server Response"
        static let invalidStatusCodeError = "Internet Error"
        static let requestStatusCodeError = "Connection Error"
        static let otherError = "Unknown Error"
        static let clientError = "Incorrect Input"
        static let serverError = "Server Error"
    }
}

enum NetworkingError: Error {
    case encodingFailed(innerError: EncodingError)
    case decodingFailed(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)
    case clientError(error: String, statusCode: HTTPStatusCode)
    case serverError(error: String, statusCode: HTTPStatusCode)
    case unknown
    
    var description: String {
        return switch self {
        case .encodingFailed:
            Styles.Text.encodingError
        case .decodingFailed:
            Styles.Text.decodingError
        case .invalidStatusCode:
            Styles.Text.invalidStatusCodeError
        case .requestFailed:
            Styles.Text.requestStatusCodeError
        case .otherError:
            Styles.Text.otherError
        case .clientError:
            Styles.Text.clientError
        case .serverError:
            Styles.Text.serverError
        case .unknown:
            Styles.Text.otherError
        }
    }
}
