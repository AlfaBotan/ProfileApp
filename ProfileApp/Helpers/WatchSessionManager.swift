//
//  WatchSessionManager.swift
//  ProfileApp
//
//  Created by Илья Волощик on 5.11.24.
//

import UIKit
import WatchConnectivity

class WatchSessionManager: NSObject {
    static let shared = WatchSessionManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func sendUserProfileData(imageName: String, age: String, height: String, weight: String) {
        if WCSession.default.activationState == .activated && WCSession.default.isReachable {
            let userData: [String: Any] = [
                "image": imageName,
                "age": age,
                "height": height,
                "weight": weight
            ]
            WCSession.default.sendMessage(userData, replyHandler: nil, errorHandler: { error in
                print("Ошибка при отправке данных на Apple Watch: \(error)")
            })
        } else {
            print("WCSession неактивна или недоступна для передачи.")
        }
    }
}


extension WatchSessionManager: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Сессия стала неактивной. Возможно, будет новая активация.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Сессия деактивирована. Перезапуск активации для новой сессии.")
        
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            print("Сессия успешно активирована.")
        } else {
            print("Не удалось активировать сессию. Статус: \(activationState.rawValue)")
        }
        
        if let error = error {
            print("Ошибка активации сессии: \(error.localizedDescription)")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let age = message["age"] as? String {
            UserDefaults.standard.set(age, forKey: UserDefaultsKeys.ProfileKeys.age.rawValue)
        }
        if let height = message["height"] as? String {
            UserDefaults.standard.set(height, forKey: UserDefaultsKeys.ProfileKeys.height.rawValue)
        }
        if let weight = message["weight"] as? String {
            UserDefaults.standard.set(weight, forKey: UserDefaultsKeys.ProfileKeys.weight.rawValue)
        }
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .profileDataDidChange, object: nil)
        }
    }
}

