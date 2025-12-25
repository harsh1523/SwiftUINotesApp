//
//  ContentView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

internal import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hii")
            Text("I am a iOS Developer")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
