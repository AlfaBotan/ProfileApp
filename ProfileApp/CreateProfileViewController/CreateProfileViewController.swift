//
//  CreateProfileViewController.swift
//  ProfileApp
//
//  Created by Илья Волощик on 4.11.24.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    private lazy var supportLable: UILabel = {
        let lable = UILabel()
        lable.text = "Аватар для профиля"
        lable.font = .systemFont(ofSize: 24, weight: .medium)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        lable.textColor = .black
        return lable
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .myBackground
        textField.textColor = .black
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Возраст"
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        textField.textAlignment = .left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .myBackground
        textField.textColor = .black
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Рост"
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        textField.textAlignment = .left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .myBackground
        textField.textColor = .black
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Вес"
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        textField.textAlignment = .left
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.isEnabled = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(createButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let watchSessionManager = WatchSessionManager.shared
    private let profileImages: [String] = (1..<7).map { "avatar_\($0)" }
    
    private var image: String?
    private var age: String?
    private var weight: String?
    private var height: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSubviews()
        addConstraints()
        setupToHideKeyboardOnTapOnView()
    }
    
    //MARK: Private func

    private func configureSubviews() {
        [supportLable,
         collectionView,
         ageTextField,
         heightTextField,
         weightTextField,
         createButton].forEach({view.addSubview($0)})
        
        if let image = UserDefaults.standard.string(forKey: UserDefaultsKeys.ProfileKeys.image.rawValue), !image.isEmpty {
            createButton.setTitle("Сохранить", for: .normal)
        } else {
            createButton.setTitle("Создать", for: .normal)
        }
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            supportLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            supportLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            supportLable.heightAnchor.constraint(equalToConstant: 60),
            supportLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: supportLable.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 75),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            ageTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),
            
            heightTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            heightTextField.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            heightTextField.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            heightTextField.heightAnchor.constraint(equalToConstant: 50),
            
            weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            weightTextField.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            weightTextField.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            weightTextField.heightAnchor.constraint(equalToConstant: 50),
            
            createButton.heightAnchor.constraint(equalToConstant: 50),
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
                    
                    if let pickCell = cell as? CustomCollectionViewCell {
                        self.image = pickCell.getImage()
                    }
                } else {
                    cell.transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    private func updateCreateButtonState() {
        if image != nil, weight != nil, height != nil, age != nil {
            createButton.isEnabled = true
            createButton.backgroundColor = .black
        } else {
            createButton.isEnabled = false
            createButton.backgroundColor = .gray
        }
    }
    
    private func saveProfileData() {
        let defaults = UserDefaults.standard
        defaults.set(image, forKey: UserDefaultsKeys.ProfileKeys.image.rawValue)
        defaults.set(age, forKey: UserDefaultsKeys.ProfileKeys.age.rawValue)
        defaults.set(weight, forKey: UserDefaultsKeys.ProfileKeys.weight.rawValue)
        defaults.set(height, forKey: UserDefaultsKeys.ProfileKeys.height.rawValue)
    }
    
    //MARK: @OBJC func

    @objc
    private func editingChanged(_ sender: UITextField) {
        if sender == ageTextField {
            if let text = sender.text, !text.isEmpty {
                age = text
            } else {
                age = nil
            }
        } else if sender == heightTextField {
            if let text = sender.text, !text.isEmpty {
                height = text
            } else {
                height = nil
            }
        } else if sender == weightTextField {
            if let text = sender.text, !text.isEmpty {
                weight = text
            } else {
                weight = nil
            }
        }
        updateCreateButtonState()
    }
    
    @objc
    private func createButtonTap() {
        if let image = UserDefaults.standard.string(forKey: UserDefaultsKeys.ProfileKeys.image.rawValue), !image.isEmpty {
            saveProfileData()
            dismiss(animated: true)
        } else {
            saveProfileData()
            let profileVC = ProfileViewController()
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.setRootViewController(profileVC)
            }
        }
    }
}

//MARK: UICollectionViewDataSource

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
        let imageName = profileImages[indexPath.row]
        cell.resetCell()
        cell.setImage(image: imageName)
        return cell
    }
}

//MARK: UICollectionViewDelegate

extension CreateProfileViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resizeCell()
        updateCreateButtonState()
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension CreateProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: collectionView.bounds.midX-35, bottom: 0, right: collectionView.bounds.midX-35)
    }
}

//MARK: UITextFieldDelegate

extension CreateProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
