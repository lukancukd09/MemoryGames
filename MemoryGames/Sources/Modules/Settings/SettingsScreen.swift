
import SwiftUI

struct SettingsScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedField") private var selectedField: String = "playingField"
    @AppStorage("selectedCard") private var selectedCard: String = "card"
    
    let fields = ["playingField", "playingField1", "playingField2", "playingField3", "playingField4", "playingField5"]
    let cards = ["card", "card2", "card3", "card4", "card5", "card6"]
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    dismiss()
                } label: {
                    Image(.backButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                
                Text("Settings")
                    .frame(maxWidth: .infinity)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .foregroundStyle(.white)
                    .textCase(.uppercase)
                    .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                    .padding(.trailing, 80)
            }
            Spacer()
            Text("Card back:")
                .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("RobotoSerif-Black", size: 24))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .padding(.top, 22)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 31), count: 4), spacing: 12) {
                ForEach(cards, id: \.self) { card in
                    Image(card)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(1)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    card == selectedCard
                                    ? Color.init(redd: 56, greenn: 210, bluee: 133)
                                    : .white.opacity(0)
                                )
                        )
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedCard = card
                            }
                        }
//                        .padding(6)
                }
            }
            .padding(.top, 20)
            
            Text("Playing field:")
                .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("RobotoSerif-Black", size: 24))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .padding(.top, 60)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 36), count: 3), spacing: 12) {
                ForEach(fields, id: \.self) { field in
                    Image(field)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(1)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    field == selectedField
                                    ? Color.init(redd: 56, greenn: 210, bluee: 133)
                                    : .white.opacity(0)
                                )
                        )
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedField = field
                            }
                        }
//                        .padding(6)
                }
            }
            .padding(.top, 20)
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
}

#Preview {
    SettingsScreen(path: .constant(.init()))
}
