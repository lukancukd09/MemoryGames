
import Foundation
import SwiftUI

struct CardView: View {
    let viewModel: CardViewModel
    @AppStorage("selectedCard") private var selectedCard: String = "card"
    var onTap: ((CardViewModel) -> Void)?
    
    init(viewModel: CardViewModel, onTap: ((CardViewModel) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    var body: some View {
        ZStack {
            if viewModel.isFaceUp || viewModel.isMatched {
                Image(viewModel.image)
                    .resizable()
                    .scaledToFit()
//                    .clipped()
//                    .padding(16)
            } else {
                Image(selectedCard) // Assuming this is the image for the card back
                    .resizable()
                    .scaledToFit()
            }
        }
//        .aspectRatio(2/3, contentMode: .fit)
        .rotation3DEffect(
            Angle(degrees: viewModel.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .opacity(viewModel.isMatched ? 0 : 1) // Cards disappear if matched
        .scaleEffect(viewModel.isMatched ? 0.5 : 1) // Cards shrink on match
        .animation(.easeInOut(duration: 0.5), value: viewModel.isFaceUp) // Flip animation
        .animation(.easeInOut(duration: 0.5), value: viewModel.isMatched) // Disappear animation
        .onTapGesture(perform: {
            onTap?(viewModel)
        })
    }
}


#Preview {
    CardView(viewModel: .init(image: "1", isMatched: false, isFaceUp: false))
}
