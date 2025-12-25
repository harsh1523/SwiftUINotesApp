//
//  AppLockManager.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

import Foundation
internal import SwiftUI
import LocalAuthentication
internal import Combine

class AppLockManager: ObservableObject {
    @Published var isAppLocked: Bool = true
    @Published var isFaceIDEnabled: Bool = true
    @Published var hasPIN: Bool = false

    private let service = "com.swiftUINotesApp"
    private let account = "userPIN"

    init() {
        checkPIN()
    }

    func checkPIN() {
        if let _ = KeychainHelper.shared.read(service: service, account: account) {
            hasPIN = true
        } else {
            hasPIN = false
        }
    }

    func savePIN(pin: String) {
        guard let data = pin.data(using: .utf8) else { return }
        KeychainHelper.shared.save(data, service: service, account: account)
        hasPIN = true
    }

    func verifyPIN(pin: String) -> Bool {
        guard let data = KeychainHelper.shared.read(service: service, account: account),
              let storedPin = String(data: data, encoding: .utf8) else { return false }
        return storedPin == pin
    }

    func authenticateWithFaceID(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock your notes"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    self.isAppLocked = !success
                    completion(success)
                }
            }
        } else {
            completion(false)
        }
    }
}
