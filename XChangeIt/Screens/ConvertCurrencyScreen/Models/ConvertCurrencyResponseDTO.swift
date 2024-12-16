//
//  ServerCurrencyReponseDTO.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

struct ConvertCurrencyResponseDTO: Decodable {
    let amount: String?
}

func convertCurrencyDataModelFromDTO(_ dto: ConvertCurrencyResponseDTO) -> ConvertCurrencyResponse {
    return ConvertCurrencyResponse(amount: dto.amount ?? "")
}
