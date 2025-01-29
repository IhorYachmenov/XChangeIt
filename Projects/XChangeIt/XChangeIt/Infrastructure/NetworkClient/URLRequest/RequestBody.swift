//
//  RequestBody.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

enum FormDataType {
    case singleValue(key: String, value: String)
    case singleMultiple(key: String, value: [String], separator: String)
    case data(key: String, value: Data)
    indirect case group(group: [FormDataType])
}

enum BodyType {
    case urlEncoded(ParameterType)
    case json([String: Any])
    
    func data(boundary: String) -> Data? {
        switch self {
        case .urlEncoded(let parameterType):
            return parameterType.toDictionary.jsonData
        case .json(let dictionary):
            return dictionary.jsonData
        }
    }
    
    func contentType(boundary: String) -> (key: String, value:String) {
        switch self {
        case .urlEncoded:
            return ("Content-Type", "application/x-www-form-urlencoded")
        case .json:
            return ("Content-Type", "application/json")
        }
    }
}

public struct RequestBody {
    let value: BodyType
}
