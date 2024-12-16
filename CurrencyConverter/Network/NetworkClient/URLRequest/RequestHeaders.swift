//
//  RequestHeaders.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

enum HeadersType {
    case singleValue(key: String, value: String)
    case multipleValue(key: String, value: [String], separator: String)
    indirect case group(group: [HeadersType])
    
    var headers: [String : String] {
        switch self {
        case .singleValue(let key, let value):
            return [key : value]
        case .multipleValue(let key, let value, let separator):
            return [key : value.joined(separator: separator)]
        case .group(let group):
            let value = group.flatMap({ $0.headers }).reduce(into: [String: String]()) { dict, pair in
                dict[pair.key] = pair.value
            }
            return value
        }
    }
}

public struct RequestHeaders {
    let value: HeadersType
}
