import SwiftUI

struct CodeGuessView: View {
    let round: Round

    var body: some View {
        HStack {
            Text("\(round.roundNumber.value)").accessibilityIdentifier("roundNumber")
            ForEach(0 ..< round.pegCount, id: \.self) { index in
                Button(action: {}, label: {
                    Circle()
                        .padding(5)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.unselected, lineWidth: 2)
                        )
                        .foregroundColor(round[index]?.color ?? Color.unselected)
                        .frame(width: 40, height: 40)
                })
                .id("guess\(round.roundNumber.value)-\(index + 1)")
            }
        }.accessibilityIdentifier("round\(round.roundNumber.value)")
    }
}
