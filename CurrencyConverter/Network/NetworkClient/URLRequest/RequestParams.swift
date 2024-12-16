//
//  RequestParams.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

enum ParameterType {
    case singleValue(key: String, value: String)
    case multipleValue(key: String, value: [String], separator: String)
    indirect case group(group: [ParameterType])
    
    var parameters: [URLQueryItem] {
        switch self {
        case .singleValue(let key, let value):
            return [URLQueryItem(name: key, value: value)]
        case .multipleValue(let key, let value, let separator):
            return [URLQueryItem(name: key, value: value.joined(separator: separator))]
        case .group(let group):
            return group.flatMap({ $0.parameters })
        }
    }
    
    var toDictionary: [String : String] {
        switch self {
        case .singleValue(let key, let value):
            return [key : value]
        case .multipleValue(let key, let value, let separator):
            return [key : value.joined(separator: separator)]
        case .group(let group):
            return group.flatMap({ $0.toDictionary }).reduce(into: [String: String]()) { dict, pair in
                dict[pair.key] = pair.value
            }
        }
    }
}

public struct RequestParams {
    let value: ParameterType
}
