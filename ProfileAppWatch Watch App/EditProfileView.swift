//
//  EditProfileView.swift
//  ProfileApp
//
//  Created by Илья Волощик on 5.11.24.
//

import SwiftUI

struct EditProfileView: View {
    
    @Binding var isPresented: Bool
    @AppStorage(UserDefaultsKeys.ProfileKeys.age.rawValue) private var age: String = ""
    @AppStorage(UserDefaultsKeys.ProfileKeys.height.rawValue) private var height: String = ""
    @AppStorage(UserDefaultsKeys.ProfileKeys.weight.rawValue) private var weight: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                TextField("Введите возраст", text: $age)
                    .padding()
                
                TextField("Введите рост", text: $height)
                    .padding()
                
                TextField("Введите вес", text: $weight)
                    .padding()
                
                Button("Сохранить") {
                    let newAge = "Возраст: \(age)"
                    let newHeight = "Рост: \(height)"
                    let newWeight = "Вес: \(weight)"
                    WatchSessionManager.shared.sendUpdatedProfileData(age: newAge, height: newHeight, weight: newWeight)
                    isPresented = false
                }
                .padding()
            }
            .padding()
        }
    }
}


