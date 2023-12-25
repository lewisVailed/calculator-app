//
//  CalculatorButton.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import UIKit

enum CalculatorButton {
    case allClear
    case plusMinus
    case percentage
    case divide
    case multiply
    case subtract
    case add
    case equals
    case number(Int)
    case decimal
    
    init(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear, .plusMinus, .percentage, .divide, .multiply, .subtract, .add, .equals, .decimal:
            self = calculatorButton
        case .number(let int):
            if int.description.count == 1 {
                self = calculatorButton
            } else {
                fatalError("number is not 1 digit")
            }
        }
    }
}

extension CalculatorButton {
    
    var color : UIColor {
        switch self {
        case .allClear, .plusMinus, .percentage:
            return .lightGray
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemOrange
        case .number, .decimal:
            return .darkGray
        }
    }
    
    var title : String {
        switch self {
        case .allClear:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .percentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equals:
            return "="
        case .number(let int):
            return int.description
        case .decimal:
            return "."
        }
    }
    
    
    
}
