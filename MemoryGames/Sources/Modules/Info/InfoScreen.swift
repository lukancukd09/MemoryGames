
import SwiftUI

struct InfoScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
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
                
                Text("Info")
                    .frame(maxWidth: .infinity)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .foregroundStyle(.white)
                    .textCase(.uppercase)
                    .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                    .padding(.trailing, 80)
            }
            
            ScrollView(showsIndicators: false) {
                Text("""
                    Find a Pair
                    Memorize card positions and find matching pairs. Trains visual memory and attention.
                    Gameplay:

                    All cards are shown briefly, then flipped face down
                    Flip two cards per turn
                    Matching pairs remain face up
                    Find all pairs in minimal time

                    Repeat After Me
                    Memorize and repeat the sequence of highlighted cards. The display speed increases with each level.
                    Gameplay:

                    Watch the card sequence carefully
                    Repeat it in the exact order
                    Each mistake costs one life
                    Three lives per level

                    Regular play improves memory, focus, and reaction time!
                    """)
                    .frame(maxWidth: .infinity)
                    .font(.custom("RobotoSerif-Medium", size: 24))
                    .foregroundStyle(Color.init(redd: 255, greenn: 236, bluee: 205))
                    .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 0)
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.authBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    InfoScreen(path: .constant(.init()))
}
