//
//  WatchSessionManager.swift
//  ProfileApp
//
//  Created by Илья Волощик on 5.11.24.
//

import WatchConnectivity
import SwiftUI

class WatchSessionManager: NSObject, ObservableObject {
    static let shared = WatchSessionManager()
    
    @Published var imageName: String = ""
    @Published var age: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
}

extension WatchSessionManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if activationState == .activated {
                print("WCSession активирована успешно.")
            } else {
                print("WCSession не активирована. Статус: \(activationState.rawValue)")
            }
            
            if let error = error {
                print("Ошибка при активации WCSession: \(error.localizedDescription)")
            }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
        if let imageName = message["image"] as? String {
            UserDefaults.standard.set(imageName, forKey: UserDefaultsKeys.ProfileKeys.image.rawValue)
        }
        
        if let age = message["age"] as? String {
            UserDefaults.standard.set(age, forKey: UserDefaultsKeys.ProfileKeys.age.rawValue)
        }
        
        if let height = message["height"] as? String {
            UserDefaults.standard.set(height, forKey: UserDefaultsKeys.ProfileKeys.height.rawValue)
        }
        
        if let weight = message["weight"] as? String {
            UserDefaults.standard.set(weight, forKey: UserDefaultsKeys.ProfileKeys.weight.rawValue)
        }
        
        // Здесь вызываем обновление интерфейса
        DispatchQueue.main.async {
            self.imageName = UserDefaults.standard.string(forKey: UserDefaultsKeys.ProfileKeys.image.rawValue) ?? ""
            self.age = UserDefaults.standard.string(forKey: UserDefaultsKeys.ProfileKeys.age.rawValue) ?? ""
            self.height = UserDefaults.standard.string(forKey: UserDefaultsKeys.ProfileKeys.height.rawValue) ?? ""
            self.weight = UserDefaults.standard.string(forKey: UserDefaultsKeys.ProfileKeys.weight.rawValue) ?? ""
        }
    }

}
