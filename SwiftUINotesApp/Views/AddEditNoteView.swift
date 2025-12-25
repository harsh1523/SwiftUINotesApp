//
//  AddEditNoteView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

internal import SwiftUI

struct AddEditNoteView: View {

    // ❗ NOT a Binding
    // ❗ NOT $vm
    @ObservedObject var vm: NotesViewModel

    let note: Note
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var content: String

    init(vm: NotesViewModel, note: Note) {
        self.vm = vm
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {

                TextField("Title", text: $title)
                    .font(.title2)
                    .padding()

                TextEditor(text: $content)
                    .padding()
            }
            .navigationTitle("Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if note.title.isEmpty && note.content.isEmpty {
                            vm.addNote(title: title, content: content)
                        } else {
                            vm.update(note: note,
                                      title: title,
                                      content: content)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}
