//
//  SwiftUINotesAppApp.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

internal import SwiftUI

@main
struct SwiftUINotesApp: App {

    @StateObject private var lockManager = AppLockManager()
    @StateObject private var notesVM = NotesViewModel() // ✅ now works

    var body: some Scene {
        WindowGroup {
            if lockManager.isAppLocked {
                AppLockView()
                    .environmentObject(lockManager)
            } else {
                NotesListView()
                    .environmentObject(lockManager)
                    .environmentObject(notesVM)
            }
        }
    }
}
