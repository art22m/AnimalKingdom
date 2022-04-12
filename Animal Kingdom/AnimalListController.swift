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
        let cell = animalListView.animalListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
