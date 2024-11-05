//
//  CreateProfileViewController.swift
//  ProfileApp
//
//  Created by Илья Волощик on 4.11.24.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Возраст"
        textField.font = .systemFont(ofSize: 12, weight: .regular)

        return textField
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Рост"
        textField.font = .systemFont(ofSize: 12, weight: .regular)

        return textField
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .gray
        textField.textColor = .white
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Вес"
        textField.font = .systemFont(ofSize: 12, weight: .regular)

        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("Создать", for: .normal)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let profileImages: [UIImage] = (1..<7).map { UIImage(named: "avatar_\($0)")! }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureSubviews()
        addConstraints()
    }
    
    private func configureSubviews() {
        [collectionView,
         ageTextField,
         heightTextField,
         weightTextField,
         createButton].forEach({view.addSubview($0)})
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 75),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            ageTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            ageTextField.heightAnchor.constraint(equalToConstant: 30),
            
            heightTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            heightTextField.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            heightTextField.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            heightTextField.heightAnchor.constraint(equalToConstant: 30),
            
            weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            weightTextField.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            weightTextField.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            weightTextField.heightAnchor.constraint(equalToConstant: 30),

            createButton.heightAnchor.constraint(equalToConstant: 30),
            createButton.widthAnchor.constraint(equalToConstant: 100),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20)
        ])
    }
    
    private func resizeCell() {
        let centerPoint = CGPoint(x: collectionView.bounds.midX,
                                  y: collectionView.bounds.midY)

        if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
            for cell in collectionView.visibleCells {
                let cellIndexPath = collectionView.indexPath(for: cell)!
                if cellIndexPath == indexPath {
                    cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                } else {
                    cell.transform = CGAffineTransform.identity
                }
            }
        }

    }
}

extension CreateProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else {
            print("Не прошёл каст")
            return UICollectionViewCell()
        }
        cell.resetCell()
        cell.setImage(image: profileImages[indexPath.row])
        return cell
    }
}

extension CreateProfileViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("просто двигаем")
        resizeCell()
       }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Начали двигать")
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Закончили двигать")

    }
}

extension CreateProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: collectionView.bounds.midX-35, bottom: 0, right: collectionView.bounds.midX-35)
    }
}

