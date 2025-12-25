//
//  NotesViewModel.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

import Foundation
internal import Combine
internal import SwiftUI

final class NotesViewModel: ObservableObject {

    // ✅ This is REQUIRED for ObservableObject
    @Published var notes: [Note] = []

    // MARK: - Storage
    private let fileName = "notes.json"

    // MARK: - Init (ACCESSIBLE)
    init() {}

    // MARK: - File URL
    private var fileURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

    // MARK: - Load
    func loadNotes() {
        do {
            let data = try Data(contentsOf: fileURL)
            notes = try JSONDecoder().decode([Note].self, from: data)
        } catch {
            notes = []
        }
    }

    // MARK: - CRUD
    func addNote(title: String, content: String) {
        let note = Note(title: title, content: content)
        notes.insert(note, at: 0)
        saveNotes()
    }

    func update(note: Note, title: String, content: String) {
        guard let index = notes.firstIndex(of: note) else { return }
        notes[index].title = title
        notes[index].content = content
        notes[index].date = .now
        saveNotes()
    }

    func delete(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }

    func toggleLock(note: Note) {
        guard let index = notes.firstIndex(of: note) else { return }
        notes[index].isLocked.toggle()
        saveNotes()
    }

    // MARK: - Save
    private func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            try data.write(to: fileURL)
        } catch {
            print("Save error:", error)
        }
    }
}
