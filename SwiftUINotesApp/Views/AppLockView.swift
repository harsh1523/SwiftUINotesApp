//
//  AppLockView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

internal import SwiftUI

struct AppLockView: View {
    @EnvironmentObject var lockManager: AppLockManager
    @State private var pin: String = ""
    @State private var showError: Bool = false

    let maxDigits = 4

    var body: some View {
        VStack(spacing: 40) {
            Text("Secure Notes")
                .font(.largeTitle)
                .bold()

            if lockManager.isFaceIDEnabled {
                Button(action: {
                    lockManager.authenticateWithFaceID { success in
                        if !success {
                            showError = true
                        }
                    }
                }) {
                    Image(systemName: "faceid")
                        .font(.system(size: 60))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }

            VStack {
                HStack {
                    ForEach(0..<maxDigits, id: \.self) { i in
                        Circle()
                            .stroke(lineWidth: 2)
                            .frame(width: 20, height: 20)
                            .background(i < pin.count ? Circle().fill(Color.gray) : Circle().fill(Color.clear))
                    }
                }
                .padding()

                if showError {
                    Text("Incorrect PIN")
                        .foregroundColor(.red)
                }
            }

            NumericKeypadView(pin: $pin, maxDigits: maxDigits) { enteredPIN in
                if lockManager.verifyPIN(pin: enteredPIN) {
                    lockManager.isAppLocked = false
                    pin = ""
                    showError = false
                } else {
                    showError = true
                    pin = ""
                }
            }

            if !lockManager.hasPIN {
                Button("Set PIN") {
                    lockManager.savePIN(pin: pin)
                    pin = ""
                }
            }
        }
        .padding()
    }
}
