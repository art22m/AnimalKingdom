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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(animalImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            animalImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            animalImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            animalImage.widthAnchor.constraint(equalToConstant: 100),
            animalImage.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
            ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    func configure(with animalModel: AnimalModel) {
        animalImage.image = animalModel.avatar ?? UIImage(named: "avatarPlaceholder")
        nameLabel.text = animalModel.fullName
        titleLabel.text = animalModel.title
    }
}
