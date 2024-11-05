//
//  ProfileViewController.swift
//  ProfileApp
//
//  Created by Илья Волощик on 4.11.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var ageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var weightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let watchSessionManager = WatchSessionManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSubviews()
        addConstraints()
        loadProfileData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProfileData()
        sendDataToWatch()
    }
    
    private func configureSubviews() {
        view.addSubview(profileImage)
        view.addSubview(ageLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(editButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            ageLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heightLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10),
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            editButton.widthAnchor.constraint(equalToConstant: 50),
            editButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func loadProfileData() {
        let defaults = UserDefaults.standard
        
        if let imageName = defaults.string(forKey: UserDefaultsKeys.ProfileKeys.image.rawValue) {
            profileImage.image = UIImage(named: imageName)
        }
       
        ageLabel.text = "Возраст: " + (defaults.string(forKey: UserDefaultsKeys.ProfileKeys.age.rawValue) ?? "не указано")
        heightLabel.text = "Рост: " + (defaults.string(forKey: UserDefaultsKeys.ProfileKeys.height.rawValue) ?? "не указано")
        weightLabel.text = "Вес: " + (defaults.string(forKey: UserDefaultsKeys.ProfileKeys.weight.rawValue) ?? "не указано")
    }
    
    private func sendDataToWatch() {
        let defaults = UserDefaults.standard
        let age = (defaults.string(forKey: UserDefaultsKeys.ProfileKeys.age.rawValue) ?? "не указано")
        let height = (defaults.string(forKey: UserDefaultsKeys.ProfileKeys.height.rawValue) ?? "не указано")
        let weight = (defaults.string(forKey: UserDefaultsKeys.ProfileKeys.weight.rawValue) ?? "не указано")
        let image = defaults.string(forKey: UserDefaultsKeys.ProfileKeys.image.rawValue) ?? "default"
        watchSessionManager.sendUserProfileData(imageName: image, age: age, height: height, weight: weight)
    }
    
    @objc
    private func editButtonTapped() {
        let createProfileVC = CreateProfileViewController()
        createProfileVC.modalPresentationStyle = .fullScreen
        self.present(createProfileVC, animated: true, completion: nil)
    }
}

