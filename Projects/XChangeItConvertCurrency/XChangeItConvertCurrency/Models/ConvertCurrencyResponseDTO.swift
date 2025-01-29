//
//  ServerCurrencyReponseDTO.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

public struct ConvertCurrencyResponseDTO: Decodable {
    let amount: String?
}

public func convertCurrencyDataModelFromDTO(_ dto: ConvertCurrencyResponseDTO) -> ConvertCurrencyResponse {
    return ConvertCurrencyResponse(amount: dto.amount ?? "")
}
