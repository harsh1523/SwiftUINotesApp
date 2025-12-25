//
//  Note.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

import Foundation

struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
    var isLocked: Bool = false // New field for per-note lock

    init(id: UUID = UUID(), title: String, content: String, date: Date = .now, isLocked: Bool = false) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.isLocked = isLocked
    }
}
