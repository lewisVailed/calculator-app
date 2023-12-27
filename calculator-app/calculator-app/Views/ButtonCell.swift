//
//  ButtonCell.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    
    static let identifier = "ButtonCell"
    
    // MARK: - Variables
    private(set) var calculatorButton: CalculatorButton!
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.text = "label"
        return label
    }()
    
    // MARK: Configure
    public func configure(with calculatorButton: CalculatorButton) {
        self.calculatorButton = calculatorButton
        self.titleLabel.text = calculatorButton.title
        self.titleLabel.backgroundColor = calculatorButton.color
    }
    
}
