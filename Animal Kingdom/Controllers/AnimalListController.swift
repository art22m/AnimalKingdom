//
//  ViewController.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 12.04.2022.
//

import UIKit

class AnimalListController: UIViewController {
    let animalListView = AnimalListView()
    
    var selectedIndex: IndexPath = IndexPath(row: -1, section: 0)
    
    var animalManager = AnimalManager()
    var animals = [AnimalModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        animalListView.animalListTable.delegate = self
        animalListView.animalListTable.dataSource = self
        animalManager.delegate = self
        
        animalManager.fetchAnimals()
        
        view = animalListView
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Animal List"
    }
}

// MARK: - UITableViewDelegate

extension AnimalListController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension AnimalListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListCell.identifier, for: indexPath) as? AnimalListCell else { return UITableViewCell() }
        
        cell.configure(with: animals[indexPath.row])
        cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath == selectedIndex) { return 360 }
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (selectedIndex == indexPath) {
            selectedIndex = IndexPath(row: -1, section: 0)
        } else {
            selectedIndex = indexPath
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.endUpdates()
    }
}

// MARK: - AnimalManagerDelegate

extension AnimalListController: AnimalManagerDelegate {
    func didFetchAnimalAvatar(_ animalManager: AnimalManager, avatar: UIImage, fullName: String) {
        let index = animals.firstIndex { $0.fullName == fullName }
        guard let index = index else {
            return
        }
        
        animals[index].avatar = avatar
        DispatchQueue.main.async {
            self.animalListView.animalListTable.beginUpdates()
            self.animalListView.animalListTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            self.animalListView.animalListTable.endUpdates()
        }
    }
    
    func didFetchAnimals(_ animalManager: AnimalManager, animals: [AnimalModel]) {
        self.animals = animals
        DispatchQueue.main.async {
            self.animalListView.acitvityIndicator.stopAnimating()
            self.animalListView.animalListTable.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
