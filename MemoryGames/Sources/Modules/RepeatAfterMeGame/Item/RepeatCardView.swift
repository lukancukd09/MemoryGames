

import SwiftUI

struct RepeatCardView: View {
    @ObservedObject var viewModel: RepeatCardViewModel
    @AppStorage("selectedCard") private var selectedCard: String = "card"
    var onTap: ((RepeatCardViewModel) -> Void)?
    
    init(viewModel: RepeatCardViewModel, onTap: ((RepeatCardViewModel) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    var body: some View {
        ZStack {
            if viewModel.isFaceUp {
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
        .opacity(viewModel.isVisible ? 1 : 0)
        .scaleEffect(viewModel.isVisible ? 1 : 0.5)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isFaceUp) // Flip animation
        .animation(.easeInOut(duration: 0.5), value: viewModel.isVisible) // Disappear animation
        .onTapGesture(perform: {
            onTap?(viewModel)
        })
    }
}

#Preview {
    RepeatCardView(viewModel: .init(id: .init(), image: "3", isFaceUp: false, isVisible: true))
}
