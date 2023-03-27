//
//  TitleCollectionReusableView.swift
//  DiffableData
//
//  Created by Alex Paul on 3/26/23.
//

import UIKit
class TitleCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "Header"
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        setupButtons()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons() {
        let buttonTitles = ["Button 1", "Button 2", "Button 3", "Button 4", "Button 5"]
        var previousButton: UIButton?
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .green
            button.translatesAutoresizingMaskIntoConstraints = false
            


            scrollView.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: scrollView.topAnchor),
                button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                button.widthAnchor.constraint(equalToConstant: 80) // Adjust button width as needed
            ])
            button.layer.cornerRadius = 0.5 * button.bounds.size.width // Make the button circular
            button.clipsToBounds = true // Clip any content that extends beyond the rounded corners
            
            if let previousButton = previousButton {
                button.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 8).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
            }
            
            previousButton = button
        }
        
        if let previousButton = previousButton {
            previousButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
