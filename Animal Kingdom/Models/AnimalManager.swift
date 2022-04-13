//
//  AnimalManager.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 13.04.2022.
//

import Foundation
import UIKit

protocol AnimalManagerDelegate {
    func didFetchAnimalAvatar(_ animalManager: AnimalManager, avatar: UIImage, fullName: String)
    func didFetchAnimals(_ animalManager: AnimalManager, animals: [AnimalModel])
    func didFailWithError(error: Error)
}

struct AnimalManager {
    var delegate: AnimalManagerDelegate?
    
    // MARK: - Fetch
    
    func fetchAnimals() {
        guard let url = URL(string: "https://animalkingdom-art22m.herokuapp.com/get_all_animals") else { return }
                
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data {
                if let animals = parseData(jsonData: safeData) {
                    delegate?.didFetchAnimals(self, animals: animals)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchAnimalAvatar(from url: String, for fullName: String) {
        guard let url = URL(string: url) else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Avatar fetching error: \(error)")
                return
            }
            
            if let safeData = data {
                if let avatar = UIImage(data: safeData) {
                    delegate?.didFetchAnimalAvatar(self, avatar: avatar, fullName: fullName)
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Parse
    
    private func parseData(jsonData: Data) -> [AnimalModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([AnimalData].self, from: jsonData)
            
            decodedData.forEach {
                self.fetchAnimalAvatar(from: $0.avatar, for: $0.firstName + " " + $0.lastName)
            }
//            self.fetchAnimalAvatar(from: decodedData[0].avatar, for: decodedData[0].firstName + " " + decodedData[0].lastName)
            
            return decodedData.map{AnimalModel(animalData: $0)}
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

