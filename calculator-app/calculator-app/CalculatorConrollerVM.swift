//
//  CalculatorConrollerVM.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import Foundation

enum CurrentNumber {
    case firstNumber
    case secondNumber
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
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: Int? = nil {didSet{self.calculatorHeaderLabel = self.firstNumber?.description ?? "0"}}
    private(set) var secondNumber: Int? = nil {didSet{self.calculatorHeaderLabel = self.secondNumber?.description ?? "0"}}
    
    private(set) var operation: CalculatorOperation? = nil
    
    // MARK: - Memory Variables
    private(set) var prevNumber: Int? = nil
    private(set) var prevOperation: CalculatorOperation? = nil
    
}

extension CalculatorConrollerVM {
    
    public func didSelectButton(with calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear:
            self.didSelectAllClear()
        case .plusMinus:
            fatalError()
        case .percentage:
            fatalError()
        case .divide:
            self.didSelectOperation(with: .divide)
        case .multiply:
            self.didSelectOperation(with: .multiply)
        case .subtract:
            self.didSelectOperation(with: .subtract)
        case .add:
            self.didSelectOperation(with: .add)
        case .equals:
            fatalError()
        case .number(let number):
            self.didSelectNumber(with: number)
        case .decimal:
            fatalError()
        }
        
        self.updateViews?()
    }
    
    private func didSelectAllClear() {
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.prevNumber = nil
        self.operation = nil
        self.prevOperation = nil
    }
    
  
}


// MARK: - Selecting Numbers
extension CalculatorConrollerVM {
    
    private func didSelectNumber(with number: Int) {
        if self.currentNumber == .firstNumber {
            
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

// MARK: - Equals and Aritmetic Operations
extension CalculatorConrollerVM {
    
    private func didSelectOperation(with operation: CalculatorOperation) {
        
        if self.currentNumber == .firstNumber {
            self.operation = operation
            self.currentNumber = .secondNumber
        } else if self.currentNumber == .secondNumber {
            
            if let prevOperation = self.operation, let firstNumber = self.firstNumber, let secondNumber = self.secondNumber {
                
                let result = self.getOperationResult(operation, firstNumber, secondNumber)
                self.secondNumber = nil
                self.firstNumber = result
                self.currentNumber = .secondNumber
                self.operation = operation
            } else {
                self.operation = operation
            }
        }
        
    }
    
    private func getOperationResult(_ operation: CalculatorOperation,_ firstNumber: Int,_ secondNumber: Int)->Int {
        switch operation {
        case .add:
            return (firstNumber + secondNumber)
        case .subtract:
            return (firstNumber - secondNumber)
        case .multiply:
            return (firstNumber * secondNumber)
        case .divide:
            return (firstNumber / secondNumber)
        }
    }
}

