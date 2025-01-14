//
//  Double.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 14/1/25.
//

import Foundation

extension Double {
    
    /// Converts a Double into a Currency with 2 decimal places
    ///  ```
    ///  Convert 1234.56 to $1,234.56
    ///  ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US") // Ensure the symbol is at the beginning
        formatter.currencyCode = "USD" // Change currency
        formatter.currencySymbol = "$" // Ensure correct symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    
    /// Converts a Double into a Currency as a String with 2 decimal places
    ///  ```
    /// Convert 1234.56 to "$1234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into String
    ///  ```
    ///  Convert 12.3456 to "$12.34"
    ///  Convert 0.123456 to "$0.12"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into String with % at the end
    ///  ```
    ///  Convert 12.3456 to "$12.34%"
    ///  Convert 0.123456 to "$0.12%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
