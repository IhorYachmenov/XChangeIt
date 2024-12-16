//
//  DefaultErrorModel.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

public struct HTTPClientDefaultError: Decodable {
    let error: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case error
        case description = "error_description"
    }
}
