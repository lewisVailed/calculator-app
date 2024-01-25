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
    private(set) lazy var calculatorHeaderLabel: String = self.firstNumber ?? "0"
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: String? = nil {didSet{self.calculatorHeaderLabel = self.firstNumber?.description ?? "0"}}
    private(set) var secondNumber: String? = nil {didSet{self.calculatorHeaderLabel = self.secondNumber?.description ?? "0"}}
    
    private(set) var operation: CalculatorOperation? = nil
    
    private(set) var firstNumberIsDecimal: Bool = false
    private(set) var secondNumberIsDecimal: Bool = false
    
    // MARK: - Memory Variables
    private(set) var prevNumber: String? = nil
    private(set) var prevOperation: CalculatorOperation? = nil
    
}

extension CalculatorConrollerVM {
    
    public func didSelectButton(with calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .allClear:
            self.didSelectAllClear()
        case .plusMinus:
            self.didSelectPlusMinus()
        case .percentage:
            self.didSelectPercentage()
        case .divide:
            self.didSelectOperation(with: .divide)
        case .multiply:
            self.didSelectOperation(with: .multiply)
        case .subtract:
            self.didSelectOperation(with: .subtract)
        case .add:
            self.didSelectOperation(with: .add)
        case .equals:
            self.didSelectEqualsButton()
        case .number(let number):
            self.didSelectNumber(with: number)
        case .decimal:
            self.didSelectDecimal()
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
        self.firstNumberIsDecimal = false
        self.secondNumberIsDecimal = false
    }
    
  
}


// MARK: - Selecting Numbers
extension CalculatorConrollerVM {
        
    private func didSelectNumber(with number: Int) {
        if self.currentNumber == .firstNumber {
            
            if var firstNumber = self.firstNumber {
                
                firstNumber.append(number.description)
                self.firstNumber = firstNumber
                self.prevNumber = firstNumber
                

            } else {
                self.firstNumber = number.description
                self.prevNumber = number.description
            }
            
        } else {
            
            if var secondNumber = self.secondNumber {
                
                secondNumber.append(number.description)
                self.secondNumber = secondNumber
                self.prevNumber = secondNumber
                
            } else {
                
                self.secondNumber = number.description
                self.prevNumber = number.description
                
            }
        }
    }
}

// MARK: - Equals and Aritmetic Operations
extension CalculatorConrollerVM {
    
    
    private func didSelectEqualsButton() {
        if let operation = self.operation, let firstNumber = self.firstNumber?.toDouble, let secondNumber = self.secondNumber?.toDouble {
            
            let result = getOperationResult(operation, firstNumber, secondNumber)
            
            self.secondNumber = nil
            self.prevOperation = operation
            self.operation = nil
            self.firstNumber = result.description
            self.currentNumber = .firstNumber
        } else if let prevOperation = self.prevOperation, let firstNumber = self.firstNumber?.toDouble, let prevNumber = self.prevNumber?.toDouble {
            
            let result = getOperationResult(prevOperation, firstNumber, prevNumber)
            self.firstNumber = result.description
        }
    }
    
    private func didSelectOperation(with operation: CalculatorOperation) {
        
        if self.currentNumber == .firstNumber {
            self.operation = operation
            self.currentNumber = .secondNumber
        } else if self.currentNumber == .secondNumber {
            
            if let prevOperation = self.operation, let firstNumber = self.firstNumber?.toDouble, let secondNumber = self.secondNumber?.toDouble {
                
                let result = self.getOperationResult(prevOperation, firstNumber, secondNumber)
                self.secondNumber = nil
                self.firstNumber = result.description
                self.currentNumber = .secondNumber
                self.operation = operation
            } else {
                self.operation = operation
            }
        }
        
    }
    
    private func getOperationResult(_ operation: CalculatorOperation,_ firstNumber: Double?,_ secondNumber: Double?)->Double {
        
        guard let firstNumber = firstNumber, let secondNumber = secondNumber else { return 0 }
        
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

extension CalculatorConrollerVM {
    
    private func didSelectPlusMinus() {
        if self.currentNumber == .firstNumber, var number = self.firstNumber {
            
            if number.contains("-") {
                number.removeFirst()
            } else {
                number.insert("-", at: number.startIndex)
            }
            
            self.firstNumber = number
            self.prevNumber = number
            
        } else if self.currentNumber == .secondNumber, var number = self.secondNumber {
        
            if number.contains("-") {
                number.removeFirst()
            } else {
                number.insert("-", at: number.startIndex)
            }
            
            self.secondNumber = number
            self.prevNumber = number
            
        }
    }
    
    private func didSelectPercentage() {
        if self.currentNumber == .firstNumber, var number = self.firstNumber?.toDouble {
            number /= 100
            
            if number.isInteger {
                self.firstNumber = number.toInt?.description
            } else {
                self.firstNumber = number.description
                self.firstNumberIsDecimal = true
            }
            
            
        } else if self.currentNumber == .secondNumber, var number = self.secondNumber?.toDouble {
            number /= 100
            
            if number.isInteger {
                self.secondNumber = number.toInt?.description
            } else {
                self.secondNumber = number.description
                self.secondNumberIsDecimal = true
            }
            
        }
    }
    
    private func didSelectDecimal() {
        
        if self.currentNumber == .firstNumber {
            
            self.firstNumberIsDecimal = true
            
            if let firstNumber = self.firstNumber, !firstNumber.contains(".") {
                self.firstNumber = firstNumber.appending(".")
            } else if self.firstNumber == nil {
                self.firstNumber = "0."
            }
            
        } else if self.currentNumber == .secondNumber {
            
            self.secondNumberIsDecimal = true
            
            if let secondNumber = self.secondNumber, !secondNumber.contains(".") {
                self.secondNumber = secondNumber.appending(".")
            } else if self.secondNumber == nil {
                self.secondNumber = "0."
            }
        }
    }

}
