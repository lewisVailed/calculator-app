//
//  CalculatorConrollerVM.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import Foundation

enum CurrentNumber {
    case first
    case second
}

class CalculatorConrollerVM {
    
    
    var updateViews: (() -> Void)?
    
    // MARK: - Datasource Array
    let calculatorButtonCells: [CalculatorButton] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    // MARK: - Variables
    private(set) lazy var calculatorHeaderLabel: String = (self.firstNumber ?? 0).description
    private(set) var currentNumber: CurrentNumber = .first
    
    private(set) var firstNumber: Int? = nil {
        didSet {
            self.calculatorHeaderLabel = self.firstNumber?.description ?? "0"
        }
    }
    
    private(set) var secondNumber: Int? = nil {
        didSet {
            self.calculatorHeaderLabel = self.secondNumber?.description ?? "0"
        }
    }
    
    private(set) var operation: CalculatorOperation? = nil
    
    // MARK: - Memory Variables
    private(set) var prevNumber: Int? = nil
    private(set) var prevOperation: CalculatorOperation? = nil
    
}

extension CalculatorConrollerVM {
    
    public func didSelectButton(with calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear:
            fatalError()
        case .plusMinus:
            fatalError()
        case .percentage:
            fatalError()
        case .divide:
            fatalError()
        case .multiply:
            fatalError()
        case .subtract:
            fatalError()
        case .add:
            fatalError()
        case .equals:
            fatalError()
        case .number(let number):
            self.didSelectNumber(with: number)
        case .decimal:
            fatalError()
        }
        
        self.updateViews?()
    }
    
}

extension CalculatorConrollerVM {
    
    private func didSelectNumber(with number: Int) {
        if self.currentNumber == .first {
            
            if let firstNumber = self.firstNumber {
                var firstNumberString = firstNumber.description
                firstNumberString.append(number.description)
                self.firstNumber = Int(firstNumberString)
                self.prevNumber = Int(firstNumberString)
            } else {
                self.firstNumber = Int(number)
                self.prevNumber = Int(number)
            }
            
        } else {
            
            if let secondNumber = self.secondNumber {
                var secondNumberString = secondNumber.description
                secondNumberString.append(number.description)
                self.secondNumber = Int(secondNumberString)
                
            } else {
                
                self.secondNumber = Int(number)
                
            }
        }

    }
}
