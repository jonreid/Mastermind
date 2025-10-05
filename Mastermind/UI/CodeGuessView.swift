import SwiftUI

struct CodeGuessView: View {
    let round: Round

    var body: some View {
        HStack {
            Text("\(round.roundNumber.value)").accessibilityIdentifier("roundNumber")
            ForEach(0 ..< round.pegCount, id: \.self) { pegIndex in
                Button(action: {}, label: {
                    Circle()
                        .padding(5)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.unselected, lineWidth: 2)
                        )
                        .foregroundColor(round[pegIndex]?.color ?? Color.unselected)
                        .frame(width: 40, height: 40)
                })
                .id("guess\(round.roundNumber.value)-\(pegIndex + 1)")
            }
        }.accessibilityIdentifier("round\(round.roundNumber.value)")
    }
}
