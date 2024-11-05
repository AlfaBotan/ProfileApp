//
//  CustomCollectionViewCell.swift
//  ProfileApp
//
//  Created by Илья Волощик on 4.11.24.
//


import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAndSetUpSubviews()
        setUpConstraints()
    }
    
    private func addAndSetUpSubviews() {
        contentView.addSubview(imageView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setImage(image: UIImage?) {
        imageView.image = image
        self.image = image
    }
    
    func resetCell() {
        imageView.image = nil
        image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
