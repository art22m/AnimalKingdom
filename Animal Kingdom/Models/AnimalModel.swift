//
//  AnimalModel.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 13.04.2022.
//

import Foundation
import UIKit

struct AnimalModel {
    var avatar: UIImage?
    let bio: String
    let firstName: String
    let lastName: String
    var id: Int?
    let title: String
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    init(avatar: UIImage?, bio: String, firstName: String, lastName: String, id: Int?, title: String) {
        self.avatar = avatar
        self.bio = bio
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.title = title
    }
    
    init(animalData: AnimalData) {
        self.avatar = nil
        self.bio = animalData.bio
        self.firstName = animalData.firstName
        self.lastName = animalData.lastName
        self.id = Int(animalData.id)
        self.title = animalData.title
    }
}
