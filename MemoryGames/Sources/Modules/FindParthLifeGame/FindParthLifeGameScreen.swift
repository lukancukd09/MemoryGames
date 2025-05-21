
import SwiftUI

struct FindParthLifeGameScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: FindParthLifeGameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: FindParthLifeGameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        HStack {
            if viewModel.isGameFinished {
//                LevelCompleteScreen(viewModel: .init(attemptCounter: viewModel.attemptСounter), path: $path) {
//                    viewModel.levelPassed()
//                    dismiss()
//                }
            } else {
                gameView
            }
        }
        .onAppear {
            viewModel.showCards()
        }
    }

    var gameView: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("backButton")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30, alignment: .leading)
                    })
                    .frame(width: geometry.size.width * 0.1)
                    
                    Spacer()

                    
                    Text("LEVEL \(viewModel.level)")
                        .font(.system(size: geometry.size.width * 0.1, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.orange, Color.red],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .shadow(color: .black, radius: 1)

                    Spacer()
                    
                    Spacer().frame(width: geometry.size.width * 0.1)
                }
                .frame(maxWidth: .infinity)
                
                Text("ATTEMPT: \(viewModel.lifes)")
                    .font(.system(size: geometry.size.width * 0.1, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 1, x: 0, y: 2)
                    .shadow(color: .black, radius: 1)

                let totalItems = viewModel.cards.count
                let columnsCount = totalItems > 0 ? Int(sqrt(Double(totalItems))) : 0
                let rowsCount = columnsCount > 0 ? (totalItems + columnsCount - 1) / columnsCount : 0

                let availableHeight = geometry.size.height / 1.4
                let availableWidth = geometry.size.width
                
                let gridSize = (columnsCount > 0 && rowsCount > 0) ?
                    min(availableWidth / CGFloat(columnsCount), availableHeight / CGFloat(rowsCount)) - 10 : 0

                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: columnsCount),
                    spacing: 10
                ) {
                    ForEach(viewModel.cards, id: \.self) { item in
                        CardView(viewModel: item, onTap: { _ in
                            if !viewModel.isCheckingMatch {
                                withAnimation(.easeInOut(duration: 1)) {
                                    viewModel.choose(card: item)
                                }
                            }
                        })
                        .frame(width: gridSize, height: gridSize)
                        .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: availableHeight)

                .padding(12)
                .background(Color.white.opacity(0.7))
                .cornerRadius(32)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 52)
            .padding(.horizontal, 24)
            .background(
                Image("gameBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
        }
    }
}

#Preview(body: {
    FindParthLifeGameScreen(viewModel: .init(id: "1", cards: [], totalPairs: 2, level: 1), path: .constant(.init()))
})
