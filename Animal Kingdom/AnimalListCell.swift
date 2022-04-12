//
//  AnimalListCell.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 13.04.2022.
//

import UIKit

class AnimalListCell: UITableViewCell {
    static let identifier = "AnimalListCell"
    
    let animalImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupViews() {
        addSubview(animalImage)
        addSubview(nameLabel)
        addSubview(titleLabel)
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            animalImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            animalImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            animalImage.widthAnchor.constraint(equalToConstant: 100),
            animalImage.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 30)
            ])
    }
}
