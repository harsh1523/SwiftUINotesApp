//
//  NoteRowView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

internal import SwiftUI

struct NoteRowView: View {
    let note: Note

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray6))
                .shadow(color: .white, radius: 3, x: -3, y: -3)
                .shadow(color: .gray.opacity(0.4), radius: 3, x: 3, y: 3)

            VStack(alignment: .leading, spacing: 6) {
                Text(note.title)
                    .font(.headline)

                Text(note.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .blur(radius: note.isLocked ? 6 : 0)
        }
        .frame(height: 80)
    }
}
