//
//  ContentView.swift
//  ProfileAppWatch Watch App
//
//  Created by Илья Волощик on 5.11.24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var watchSessionManager = WatchSessionManager.shared
    @State private var isEditPresented = false
    
    @AppStorage(UserDefaultsKeys.ProfileKeys.age.rawValue) private var age: String = "Не указано"
    @AppStorage(UserDefaultsKeys.ProfileKeys.height.rawValue) private var height: String = "Не указано"
    @AppStorage(UserDefaultsKeys.ProfileKeys.weight.rawValue) private var weight: String = "Не указано"
    @AppStorage(UserDefaultsKeys.ProfileKeys.image.rawValue) private var image: String = "default"
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                Text("Возраст: \(age)")
                Text("Рост: \(height)")
                Text("Вес: \(weight)")
                
                Spacer()
                
                Button(action: {
                    isEditPresented = true
                }) {
                    Label("Редактировать", systemImage: "pencil")
                }
                .padding(.bottom, 20)
            }
            .padding()
            
        }
        .sheet(isPresented: $isEditPresented) {
            EditProfileView(isPresented: $isEditPresented)
        }
    }
}
