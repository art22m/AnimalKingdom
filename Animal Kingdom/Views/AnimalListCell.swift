//
//  AnimalListCell.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 13.04.2022.
//

import UIKit

class AnimalListCell: UITableViewCell {
    // MARK: - Views
    
    static let identifier = "AnimalListCell"
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    let animalImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
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
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        clipsToBounds = true
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        contentView.addSubview(animalImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bioTextView)
    }
    
    private func setupConstaints() {
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
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: animalImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        NSLayoutConstraint.activate([
            bioTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bioTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bioTextView.topAnchor.constraint(equalTo: animalImage.bottomAnchor, constant: 5),
            bioTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            ])
    }
    
    // MARK: - Settings
    
    func configure(with animalModel: AnimalModel) {
        animalImage.image = animalModel.avatar ?? UIImage(named: "avatarPlaceholder")
        nameLabel.text = animalModel.fullName
        titleLabel.text = animalModel.title
        bioTextView.text = animalModel.bio
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        })
    }
}
