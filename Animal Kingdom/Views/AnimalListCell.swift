//
//  AnimalListCell.swift
//  Animal Kingdom
//
//  Created by Artem Murashko on 13.04.2022.
//

import UIKit

class AnimalListCell: UITableViewCell {
    static let identifier = "AnimalListCell"
    
    // MARK: - Views
    let expandButton: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "rectangle.expand.vertical")
        button.tintColor = .black
        
        return button
    }()
    
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
        addSubview(animalImage)
        addSubview(nameLabel)
        addSubview(titleLabel)
        addSubview(bioTextView)
        addSubview(expandButton)
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
            expandButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            expandButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            expandButton.widthAnchor.constraint(equalToConstant: 25),
            expandButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            bioTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bioTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
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

extension UIImageView {
    func rotateClockwise() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: CGFloat.pi)
        rotation.duration = 0.2
        rotation.isCumulative = true
        rotation.repeatCount = 1
        rotation.fillMode = .forwards
        rotation.isRemovedOnCompletion = false
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
