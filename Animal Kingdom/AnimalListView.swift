//
//  AnimalListView.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 12.04.2022.
//

import UIKit

class AnimalListView: UIView {    
    let animalListTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    private func setupLayout() {
        addSubview(animalListTable)
        NSLayoutConstraint.activate([
            animalListTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            animalListTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            animalListTable.topAnchor.constraint(equalTo: topAnchor),
            animalListTable.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
