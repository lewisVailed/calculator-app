//
//  CalculatorOperation.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 28.12.2023.
//

import Foundation

enum CalculatorOperation {
    case add
    case subtract
    case multiply
    case divide
    
    var title: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "x"
        case .divide:
            return "÷"
        }
    }
    
}
