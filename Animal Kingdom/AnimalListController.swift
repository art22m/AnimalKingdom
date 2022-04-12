//
//  ViewController.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 12.04.2022.
//

import UIKit

class AnimalListController: UIViewController {
    let animalListView = AnimalListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        animalListView.animalListTable.delegate = self
        animalListView.animalListTable.dataSource = self
        
        view = animalListView
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Animal List"
    }
}

extension AnimalListController: UITableViewDelegate {
    
}

extension AnimalListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListCell.identifier, for: indexPath) as? AnimalListCell else { return UITableViewCell() }
        
        cell.configure(with: AnimalModel(avatar: nil, bio: "123", firstName: "123", secondName: "123", id: 2, title: "123"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
