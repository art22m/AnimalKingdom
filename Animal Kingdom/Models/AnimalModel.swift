//
//  AnimalModel.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 13.04.2022.
//

import Foundation
import UIKit

struct AnimalModel {
    let avatar: UIImage?
    let bio: String
    let firstName: String
    let secondName: String
    let id: Int
    let title: String
    
    var fullName: String {
        return firstName + " " + secondName
    }
//    init(avatar: UIImage, bio: Stirng, firstName: String, secondName: String, id: Int, title: String) {
//        self.avatar = avatar
//        self.bio = bio
//        self.firstName = firstName
//    }
}
