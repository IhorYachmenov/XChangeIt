//
//  Dictionary+JSON.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

extension Dictionary {
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
}
