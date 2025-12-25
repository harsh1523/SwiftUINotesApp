//
//  NumericKeyPadView.swift
//  SwiftUINotesApp
//
//  Created by Harsh on 25/12/25.
//

internal import SwiftUI

struct NumericKeypadView: View {
    @Binding var pin: String
    var maxDigits: Int
    var onComplete: (String) -> Void

    let buttons = [
        ["1","2","3"],
        ["4","5","6"],
        ["7","8","9"],
        ["⌫","0","✓"]
    ]

    var body: some View {
        VStack(spacing: 15) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 15) {
                    ForEach(row, id: \.self) { button in
                        Button(action: { handleTap(button) }) {
                            Text(button)
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
    }

    private func handleTap(_ button: String) {
        switch button {
        case "⌫":
            if !pin.isEmpty { pin.removeLast() }
        case "✓":
            if pin.count == maxDigits { onComplete(pin) }
        default:
            if pin.count < maxDigits { pin.append(button) }
        }
    }
}
