
import SwiftUI

struct FindParthCountGameScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: FindParthCountGameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @State private var isPaused: Bool = false
    @AppStorage("selectedField") private var selectedField: String = "playingField"
    
    init(viewModel: FindParthCountGameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {

                ZStack {
                    gameView
                    if viewModel.isGameFinished {
                        VStack(spacing: 0) {
                            Text("You win")
                                .frame(maxWidth: .infinity)
                                .font(.custom("RobotoSerif-Black", size: 52))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                                .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                            
                            Text("remains")
                                .frame(maxWidth: .infinity)
                                .font(.custom("RobotoSerif-Black", size: 24))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                                .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                            
                            Text(viewModel.timerString)
                                .frame(maxWidth: .infinity)
                                .font(.custom("RobotoSerif-Black", size: 44))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                                .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
                            
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
                                viewModel.startTimer()
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
                        .onAppear {
                            viewModel.showCards()
                        }
    }

    var gameView: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button {
                        isPaused = true
                        viewModel.stopTimer()
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
                .frame(maxWidth: .infinity)
                
                Text("\(viewModel.timerString)")
                    .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                    .font(.custom("RobotoSerif-Black", size: 60))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)

                let totalItems = viewModel.cards.count
                let columnsCount = totalItems > 0 ? Int(sqrt(Double(totalItems))) : 0
                let rowsCount = columnsCount > 0 ? (totalItems + columnsCount - 1) / columnsCount : 0

                let availableHeight = geometry.size.height / 1.4
                let availableWidth = geometry.size.width
                
                let gridSize = (columnsCount > 0 && rowsCount > 0) ?
                    min(availableWidth / CGFloat(columnsCount), availableHeight / CGFloat(rowsCount)) - 20 : 0

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
//                        .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: availableHeight)
                .padding(30)
                .background(
                    Image(selectedField)
                        .resizable()
                        .scaledToFill()
                )
//                .cornerRadius(32)
                Spacer()
            }
//            .padding(.horizontal, 16)
//            .padding(.bottom, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            .background(
                Image(.mainBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview(body: {
    FindParthCountGameScreen(viewModel: .init(id: "1", cards: [], totalPairs: 2, level: 1), path: .constant(.init()))
})
