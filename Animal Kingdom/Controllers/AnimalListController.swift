//
//  ViewController.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 12.04.2022.
//

import UIKit

class AnimalListController: UIViewController {
    // MARK: - Properties
    let animalListView = AnimalListView()
    
    var selectedIndex: IndexPath = IndexPath(row: -1, section: 0)
    
    var animalManager = AnimalManager()
    var animals = [AnimalModel]()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let retryAction = UIAlertAction(title: "Retry", style: .cancel) { UIAlertAction in
            if self.animals.isEmpty {
                self.animalManager.fetchAnimals()
            }
        }
        animalListView.errorAlert.addAction(retryAction)
        createAddButton() // creates add button for addAlert
        
        animalListView.animalListTable.delegate = self
        animalListView.animalListTable.dataSource = self
        animalManager.delegate = self
        
        animalManager.fetchAnimals()
        
        view = animalListView
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAnimalTapped(sender:)))
        navigationItem.title = "Animal List"
    }
    
    @objc
    func addAnimalTapped(sender: UIButton) {
        present(animalListView.addAnimalAlert, animated: true)
    }
    
    func createAddButton() {
        let addAnimalAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let fields = self.animalListView.addAnimalAlert.textFields,
                  fields.count == 5 else { return }
            
            let firstNameField = fields[0]
            let lastNameField = fields[1]
            let titleField = fields[2]
            let bioField = fields[3]
            let avatarURLField = fields[4]
            
            guard let firstName = firstNameField.text, !firstName.isEmpty,
                let lastName = lastNameField.text, !lastName.isEmpty,
                let title = titleField.text, !title.isEmpty,
                let bio = bioField.text, !bio.isEmpty,
                let avatarURL = avatarURLField.text, !avatarURL.isEmpty else {
                return
            }
            
            // Add new animal to the server and to the table
            let id = Int.random(in: 0...10000)
            self.animals.append(AnimalModel(avatar: nil, bio: bio, firstName: firstName, lastName: lastName, id: id, title: bio))
            self.animalManager.uploadAnimal(animalData: AnimalData(avatar: avatarURL, bio: bio, firstName: firstName, lastName: lastName, id: String(id), title: title))
            
            // Update table
            self.animalListView.animalListTable.beginUpdates()
            self.animalListView.animalListTable.insertRows(at: [IndexPath(row: self.animals.count - 1, section: 0)], with: .none)
            self.animalListView.animalListTable.endUpdates()
        }
        
        animalListView.addAnimalAlert.addAction(addAnimalAction)
    }
}

// MARK: - UITableViewDelegate

extension AnimalListController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension AnimalListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListCell.identifier, for: indexPath) as? AnimalListCell else { return UITableViewCell() }
        
        cell.configure(with: animals[indexPath.row])
        cell.animate()
        if (selectedIndex == indexPath) {
            cell.expandButton.rotateClockwise()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath == selectedIndex ? 360 : 120
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
        DispatchQueue.main.async {
            if (self.presentedViewController == nil) {
                self.animalListView.errorAlert.message = error.localizedDescription
                self.present(self.animalListView.errorAlert, animated: true, completion: nil)
            }
        }
    }
}
