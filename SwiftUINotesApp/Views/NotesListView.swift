//
//  NotesListView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//
internal import SwiftUI

struct NotesListView: View {

    // MARK: - Dependencies
    @EnvironmentObject var vm: NotesViewModel

    // MARK: - UI State
    @State private var selectedNote: Note?
    @State private var unlockNote: Note?
    @State private var searchText = ""

    // MARK: - Filter
    private var filteredNotes: [Note] {
        if searchText.isEmpty {
            return vm.notes
        } else {
            return vm.notes.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    // MARK: - View
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {

                notesList

                addButton
            }
            .navigationTitle("Notes")
            .onAppear {
                vm.loadNotes()   // ✅ HERE
            }
        }
        .sheet(item: $selectedNote) { note in
            AddEditNoteView(vm: vm, note: note)
        }
        .fullScreenCover(item: $unlockNote) { note in
            UnlockNoteView(note: note) { success in
                if success {
                    vm.toggleLock(note: note)   // ✅ correct
                }
                unlockNote = nil
            }
        }
    }

    // MARK: - Notes List
    private var notesList: some View {
        List {
            ForEach(filteredNotes) { note in
                NoteRowView(note: note)
                    .onTapGesture {
                        handleTap(note)
                    }
                    .swipeActions {
                        lockAction(note)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .onDelete(perform: vm.delete)
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
    }

    // MARK: - Actions
    private func handleTap(_ note: Note) {
        if note.isLocked {
            unlockNote = note
        } else {
            selectedNote = note
        }
    }

    private func lockAction(_ note: Note) -> some View {
        Button {
            vm.toggleLock(note: note)   // ✅ correct
        } label: {
            Label(
                note.isLocked ? "Unlock" : "Lock",
                systemImage: note.isLocked ? "lock.open" : "lock"
            )
        }
        .tint(note.isLocked ? .green : .orange)
    }

    // MARK: - Floating Add Button
    private var addButton: some View {
        Button {
            selectedNote = Note(title: "", content: "")
        } label: {
            Image(systemName: "plus")
                .font(.title)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .shadow(color: .white, radius: 3, x: -3, y: -3)
                .shadow(color: .gray.opacity(0.4), radius: 3, x: 3, y: 3)
        }
        .padding()
    }
}
