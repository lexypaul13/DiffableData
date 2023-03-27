//
//  ItemCollectionViewCell.swift
//  DiffableData
//
//  Created by Alex Paul on 3/26/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    // Create UI elements to display item content
    private let titleLabel = UILabel()
    private let dogImage = UIImageView()
    static let reuseIdentifier = "Header"

    // Set up the cell's appearance and layout
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the UI elements to the cell's content view
        contentView.addSubview(dogImage)
        contentView.addSubview(titleLabel)

        
        // Set up the appearance of the UI elements
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        // Set up the layout constraints for the UI elements
        // Set up the layout constraints for the UI elements
        // Set up the layout constraints for the UI elements
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        dogImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            dogImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dogImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dogImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dogImage.heightAnchor.constraint(equalTo: dogImage.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                titleLabel.heightAnchor.constraint(equalToConstant: 40), // Adjust the height according to your preference
                titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])


    }
    
    // Configure the cell's content with an item object
    func configure(with item: Item) {
        titleLabel.text = item.title
        dogImage.image = item.images
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

