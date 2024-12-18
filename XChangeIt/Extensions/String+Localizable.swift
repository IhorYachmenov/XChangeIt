//
//  String+Localizable.swift
//  XChangeIt
//
//  Created by Ice on 18.12.2024.
//

import Foundation

extension String {
    static func localizable(key: String, table: AppLocalizedTables) -> String {
        return NSLocalizedString(key, tableName: table.rawValue, comment: "")
    }
}
