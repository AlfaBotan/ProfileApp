//
//  EditProfileView.swift
//  ProfileApp
//
//  Created by Илья Волощик on 5.11.24.
//

import SwiftUI

import SwiftUI

struct EditProfileView: View {
    @Binding var isPresented: Bool // Связываем представление с родительским экраном
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
                    
                    isPresented = false
                }
                .padding()
            }
            .padding()
        }
    }
}


