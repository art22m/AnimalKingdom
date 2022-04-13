//
//  AnimalListView.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 12.04.2022.
//

import UIKit

class AnimalListView: UIView {
    // MARK: - Views
    
    let acitvityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        return indicator
    }()
    
    let animalListTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        table.register(AnimalListCell.self, forCellReuseIdentifier: AnimalListCell.identifier)
        
        return table
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(animalListTable)
        NSLayoutConstraint.activate([
            animalListTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            animalListTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            animalListTable.topAnchor.constraint(equalTo: topAnchor),
            animalListTable.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        addSubview(acitvityIndicator)
        NSLayoutConstraint.activate([
            acitvityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            acitvityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
