
import SwiftUI

struct FirstOnboardingScreen: View {
    @State private var viewModel: FirstOnboardingViewModel = .init()
    @State private var path: NavigationPath = .init()
    @StateObject private var authMain = AuthMain()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                Image(.onb)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 16)
                    .shadow(color: Color.init(redd: 173, greenn: 57, bluee: 1, opacity: 0.8), radius: 2, x: 0, y: 2)
                
                VStack(spacing: 0) {
                    Text("Hi there!")
                        .frame(maxWidth: .infinity)
                        .font(.custom("RobotoSerif-ExtraBold", size: 64))
                        .foregroundStyle(.white)
                        .customStroke(color: Color.init(redd: 171, greenn: 56, bluee: 1), width: 2)
                    
                    Text("Here you can enjoy our game")
                        .frame(maxWidth: .infinity)
                        .font(.custom("RobotoSerif-Regular", size: 32))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .init(redd: 171, greenn: 56, bluee: 1), radius: 4, x: 0, y: 0)
                }
                .padding(.vertical, 16)
                .background(Color.init(redd: 171, greenn: 56, bluee: 1, opacity: 0.8))
                .padding(.top, 24)
                
                Spacer()
                
                Button {
                    path.append(Router.root)
                } label: {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                        .textCase(.uppercase)
                        .font(.custom("RobotoSerif-Bold", size: 32))
                        .foregroundStyle(Color(redd: 209, greenn: 85, bluee: 25))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 21)
                }
                .background(.white)
                .cornerRadius(60)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                .padding(.horizontal, 46)
                .padding(.bottom, 40)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.authBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
            .navigationDestination(for: Router.self) { router in
                switch router {
                case .main:
                    MainScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .root:
                    RootScreen(viewModel: .init(), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .levels(let category):
                    LevelListScreen(viewModel: .init(category: category), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .info:
                    InfoScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .profile:
                    ProfileScreen(viewModel: .init(), authMain: authMain, path: $path)
                        .navigationBarBackButtonHidden(true)
                case .settigs:
                    SettingsScreen(path: $path)
                        .navigationBarBackButtonHidden(true)
                case .game1(let level):
                    FindParthCountGameScreen(viewModel: .init(id: level.id, cards: [], totalPairs: level.pairs, level: level.level), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .game2(let level):
                    RepeatAfterMeGameScreen(viewModel: .init(id: level.id, level: level.level), path: $path)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    FirstOnboardingScreen()
}
