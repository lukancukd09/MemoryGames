
import SwiftUI

struct LevelListScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: LevelListViewModel
    @State private var currentPage = 0
    
    init(viewModel: LevelListViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var topBar: some View {
        HStack(spacing: 0) {
            Button {
                dismiss()
            } label: {
                Image(.backButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            
            Text(viewModel.category == .pairs ? "Find a couple" : "Memory")
                .frame(maxWidth: .infinity)
                .font(.custom("RobotoSerif-Black", size: 28))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
                .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                .padding(.trailing, 80)
        }
    }
        
    
    var body: some View {
        ZStack {
            Image(.mainBackground)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                topBar
                    .padding(.horizontal, 16)
                
                pager
                
                playButton
                    .padding(.horizontal, 16)
                
                pageTabView
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .onAppear {
            viewModel.reloadData()
        }
    }
    
    var pager: some View {
        TabView(selection: $currentPage) {
            ForEach(viewModel.levels) { level in
                levelPageView(level: level)
                    .tag(level.level - 1)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .tabViewStyle(
            PageTabViewStyle(indexDisplayMode: .never)
        )
    }
    
    func levelPageView(level: Level) -> some View {
        VStack(spacing: 16) {
            levelImageView(level: level)

            levelNameText(level: level)
        }
    }
    
    func levelNameText(level: Level) -> some View {
        Text(level.title)
            .frame(maxWidth: .infinity)
            .font(.custom("RobotoSerif-Black", size: 64))
            .foregroundStyle(.white)
            .textCase(.uppercase)
            .multilineTextAlignment(.center)
            .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
    }
    
    func levelImageView(level: Level) -> some View {
        Image(level.image)
    }
    
    var playButton: some View {
        Button {
            let currentLevel = viewModel.levels[currentPage]
            
            if viewModel.category == .pairs {
                path.append(Router.game1(currentLevel))
            } else {
                path.append(Router.game2(currentLevel))
            }
        } label: {
            Text("Play")
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
        .padding(.top, 20)
        .padding(.bottom, 40)
    }
    
    var pageTabView: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< viewModel.levels.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 6)
                    .fill(
                        index == currentPage
                        ? Color(redd: 57, greenn: 214, bluee: 141)
                        : Color(redd: 175, greenn: 203, bluee: 101)
                        
                    )
                    .frame(
                        width: index == currentPage ? 44 : 12,
                        height: 12
                    )
                    .animation(.easeInOut(duration: 0.2), value: currentPage)
            }
        }
    }
}

#Preview {
    LevelListScreen(viewModel: .init(category: .pairs), path: .constant(.init()))
}
