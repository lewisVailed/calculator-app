//
//  Extensions.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 28.12.2023.
//

import Foundation

// converts double to int
extension Double {
    var toInt: Int? {
        return Int(self)
    }
}

// converts string to double
extension String {
    var toDouble: Double? {
        return Double(self)
    }
}

// checking integer floating point
extension FloatingPoint {
    var isInteger: Bool { return rounded() == self }
}
