//
//  DateFormatter+Extentions.swift
//  
//
//  Created by Mouad Bj on 13/7/2023.
//

import Foundation

extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
  }()
}
