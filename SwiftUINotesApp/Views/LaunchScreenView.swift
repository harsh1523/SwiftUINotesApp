//
//  LaunchScreenView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//
internal import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)

                Text("Secure Notes")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.gray)
            }
        }
    }
}
