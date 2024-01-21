//
//  HeaderCell.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import UIKit

class HeaderCell: UICollectionReusableView {
 
    static let identifier = "HeaderCell"
    
    // MARK: - UI Components
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font  = .systemFont(ofSize: 72, weight: .regular)
        label.text = "label"
        
        return label
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(currentNumberText: String) {
        self.headerLabel.text = currentNumberText
        
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(self.headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.headerLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
        
        ])
        
    }
    
}
