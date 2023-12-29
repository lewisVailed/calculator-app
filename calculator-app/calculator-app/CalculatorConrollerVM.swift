//
//  CalculatorConrollerVM.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import Foundation

class CalculatorConrollerVM {
    
    enum CurrentNumber {
        case first
        case second
    }
    
    // MARK: - Datasource Array
    let calculatorButtonCells: [CalculatorButton] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    // MARK: - Variables
    private(set) lazy var calculatorHeaderLabel: String = "21"
    private(set) var currentNumber: CurrentNumber = .first
    
    private(set) var firstNumber: Int? = nil
    private(set) var secondNumber: Int? = nil
    
}

extension CalculatorConrollerVM {
    
    public func didSelectButton(with calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear:
            <#code#>
        case .plusMinus:
            <#code#>
        case .percentage:
            <#code#>
        case .divide:
            <#code#>
        case .multiply:
            <#code#>
        case .subtract:
            <#code#>
        case .add:
            <#code#>
        case .equals:
            <#code#>
        case .number(let int):
            <#code#>
        case .decimal:
            <#code#>
        }
    }
    
}

extension CalculatorConrollerVM {
    
    private func didSelectNumber(with number: Int) {
        if self.currentNumber == .first {
            if let firstNumber = firstNumber {
                var firstNumberString = firstNumber.description
                firstNumberString.append(firstNumber.description)
                self.firstNumber = Int(firstNumberString)
            } else {
                self.firstNumber = Int(number)
            }
            
                
        }

    }
}
