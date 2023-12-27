//
//  CalculatorController.swift
//  calculator-app
//
//  Created by Ayberk Bilgiç on 14.12.2023.
//

import UIKit

class CalculatorController: UIViewController {

    // MARK: - Variables
    let viewModel: CalculatorConrollerVM
    
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        
        // defines the layout and determines the scroll direction
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        // Registers the information type for the collection view.
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.setupUI()
        
        // delegate and datasource protocols are defined
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

    init(_ viewModel: CalculatorConrollerVM = CalculatorConrollerVM()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        //Is where view objects are added
        self.view.addSubview(self.collectionView)
        
        //It is important for auto layout usage
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

// MARK: - Extension
extension CalculatorController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Buttons
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calculatorButtonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else {
            fatalError("Failed to dequeue ButtonCell in CC")
        }
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        cell.configure(with: calculatorButton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/5, height: view.frame.size.height/5)
    }
        
}


