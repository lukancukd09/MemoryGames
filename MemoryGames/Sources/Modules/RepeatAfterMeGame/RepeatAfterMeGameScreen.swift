
import SwiftUI

struct RepeatAfterMeGameScreen: View {
    @ObservedObject var viewModel: RepeatAfterMeGameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @State private var isPaused: Bool = false
    @AppStorage("selectedField") private var selectedField: String = "playingField"
    
    init(viewModel: RepeatAfterMeGameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        ZStack {
            gameView
            if viewModel.isGameOver {
                VStack(spacing: 0) {
                    Text(viewModel.gameResult == .win ? "You win" : "You lose")
                        .frame(maxWidth: .infinity)
                        .font(.custom("RobotoSerif-Black", size: 52))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                    
                    if viewModel.gameResult == .win {
                        Text("remains")
                            .frame(maxWidth: .infinity)
                            .font(.custom("RobotoSerif-Black", size: 24))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                            .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                        
                        HStack {
                            ForEach(0 ..< 3, id: \.self) { index in
                                Spacer()
                                Image(index < viewModel.lifes ? .mark2 : .mark3)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                Spacer()
                            }
                        }
                        
                        Button {
                            viewModel.goToNextLevel()
                        } label: {
                            Text("Next level")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .font(.custom("RobotoSerif-Black", size: 44))
                                .textCase(.uppercase)
                                .padding(.vertical, 12)
                                .customStroke(color: Color.init(redd: 39, greenn: 189, bluee: 114), width: 1)
                        }
                        .padding(.vertical, 12)
                        .background(RadialGradient(colors: [
                            Color.init(redd: 64, greenn: 246, bluee: 228),
                            Color.init(redd: 56, greenn: 210, bluee: 133)
                        ], center: .top, startRadius: 1, endRadius: 160))
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.init(redd: 42, greenn: 196, bluee: 119), lineWidth: 16)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        .padding(.top, 8)
                        
                    } else {
                        Text("remains")
                            .frame(maxWidth: .infinity)
                            .font(.custom("RobotoSerif-Black", size: 24))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                            .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                        
                        HStack {
                            ForEach(0 ..< 3, id: \.self) { index in
                                Spacer()
                                Image(index < viewModel.lifes ? .mark2 : .mark3)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                Spacer()
                            }
                        }
                        
                        Button {
                            viewModel.startNewGame()
                        } label: {
                            Text("Restart")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .font(.custom("RobotoSerif-Black", size: 44))
                                .textCase(.uppercase)
                                .padding(.vertical, 12)
                                .customStroke(color: Color.init(redd: 39, greenn: 189, bluee: 114), width: 1)
                        }
                        .padding(.vertical, 12)
                        .background(RadialGradient(colors: [
                            Color.init(redd: 64, greenn: 246, bluee: 228),
                            Color.init(redd: 56, greenn: 210, bluee: 133)
                        ], center: .top, startRadius: 1, endRadius: 160))
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.init(redd: 42, greenn: 196, bluee: 119), lineWidth: 16)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        .padding(.top, 8)
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Exit")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.custom("RobotoSerif-Black", size: 44))
                            .textCase(.uppercase)
                            .padding(.vertical, 12)
                            .customStroke(color: Color.init(redd: 39, greenn: 189, bluee: 114), width: 1)
                    }
                    .padding(.vertical, 18)
                    .background(RadialGradient(colors: [
                        Color.init(redd: 64, greenn: 246, bluee: 228),
                        Color.init(redd: 56, greenn: 210, bluee: 133)
                    ], center: .top, startRadius: 1, endRadius: 160))
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.init(redd: 42, greenn: 196, bluee: 119), lineWidth: 16)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                    .padding(.top, 8)
                }
                .padding(24)
                .background(RadialGradient(colors: [
                    Color.init(redd: 198, greenn: 64, bluee: 246),
                    Color.init(redd: 113, greenn: 56, bluee: 210)
                ], center: .top, startRadius: 1, endRadius: 160))
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.init(redd: 104, greenn: 47, bluee: 202), lineWidth: 16)
                )
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.init(redd: 68, greenn: 24, bluee: 3, opacity: 0.6))
            }
            
            if isPaused {
                VStack(spacing: 0) {
                    Text("Pause")
                        .frame(maxWidth: .infinity)
                        .font(.custom("RobotoSerif-Black", size: 64))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                    
                    Button {
                        isPaused = false
                    } label: {
                        Text("Resume")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.custom("RobotoSerif-Black", size: 44))
                            .textCase(.uppercase)
                            .padding(.vertical, 12)
                            .customStroke(color: Color.init(redd: 39, greenn: 189, bluee: 114), width: 1)
                    }
                    .padding(.vertical, 12)
                    .background(RadialGradient(colors: [
                        Color.init(redd: 64, greenn: 246, bluee: 228),
                        Color.init(redd: 56, greenn: 210, bluee: 133)
                    ], center: .top, startRadius: 1, endRadius: 160))
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.init(redd: 42, greenn: 196, bluee: 119), lineWidth: 16)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                    .padding(.top, 8)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Exit")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.custom("RobotoSerif-Black", size: 44))
                            .textCase(.uppercase)
                            .padding(.vertical, 12)
                            .customStroke(color: Color.init(redd: 39, greenn: 189, bluee: 114), width: 1)
                    }
                    .padding(.vertical, 18)
                    .background(RadialGradient(colors: [
                        Color.init(redd: 64, greenn: 246, bluee: 228),
                        Color.init(redd: 56, greenn: 210, bluee: 133)
                    ], center: .top, startRadius: 1, endRadius: 160))
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.init(redd: 42, greenn: 196, bluee: 119), lineWidth: 16)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                    .padding(.top, 8)
                }
                .padding(24)
                .background(RadialGradient(colors: [
                    Color.init(redd: 198, greenn: 64, bluee: 246),
                    Color.init(redd: 113, greenn: 56, bluee: 210)
                ], center: .top, startRadius: 1, endRadius: 160))
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.init(redd: 104, greenn: 47, bluee: 202), lineWidth: 16)
                )
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.init(redd: 68, greenn: 24, bluee: 3, opacity: 0.6))
            }
        }
    }

    var gameView: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button {
                        isPaused = true
                    } label: {
                        Image(.stopButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }

                    Spacer()

                    Text("lvl \(viewModel.level)")
                        .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom("RobotoSerif-Black", size: 28))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                }

                HStack {
                    ForEach(0 ..< 3, id: \.self) { index in
                        Spacer()
                        Image(index < viewModel.lifes ? .mark : .mark1)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        Spacer()
                    }
                }
                .padding(.top, 20)
                
                let totalItems = viewModel.cards.count
                let columnsCount = totalItems > 0 ? Int(sqrt(Double(totalItems))) : 0
                let rowsCount = columnsCount > 0 ? (totalItems + columnsCount - 1) / columnsCount : 0

                let availableHeight = geometry.size.height / 1.4
                let availableWidth = geometry.size.width
                
                let gridSize = (columnsCount > 0 && rowsCount > 0) ?
                    min(availableWidth / CGFloat(columnsCount), availableHeight / CGFloat(rowsCount)) : 0

                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: columnsCount),
                    spacing: 10
                ) {
                    ForEach(viewModel.cards.indices, id: \.self) { index in
                        let card = viewModel.cards[index]
                        Group {
                            if card.isVisible {
                                RepeatCardView(viewModel: card) { tapped in
                                    if !viewModel.isShowingSequence {
                                        viewModel.playerTapped(card: tapped)
                                    }
                                }
                            } else {
                                Image("")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .frame(width: gridSize, height: gridSize)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: availableHeight)
                .padding(30)
                .background(
                    Image(selectedField)
                        .resizable()
                        .scaledToFill()
                )
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.mainBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
        }
        .onAppear {
            if viewModel.cards.isEmpty {
                viewModel.setupCards()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                viewModel.startNewGame()
            }
        }
    }
}


#Preview {
    RepeatAfterMeGameScreen(viewModel: .init(id: "", level: 1), path: .constant(.init()))
}

extension View {
    func responsiveFrame(widthPercentage: CGFloat, heightPercentage: CGFloat) -> some View {
        self
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .aspectRatio(1, contentMode: .fit)
            .frame(
                width: UIScreen.main.bounds.width * widthPercentage,
                height: UIScreen.main.bounds.height * heightPercentage
            )
    }
}
