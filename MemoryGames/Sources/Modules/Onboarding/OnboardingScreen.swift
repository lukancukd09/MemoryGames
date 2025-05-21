

import SwiftUI

struct OnboardingScreen: View {
    @State private var leftOffset: CGFloat = -100
    @State private var rightOffset: CGFloat = 100
    @State private var isLoad: Bool = false
    
    var body: some View {
        if isLoad {
            FirstOnboardingScreen()
        } else {
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Image(.ellipse1)
                        .frame(width: 100, height: 100)
                        .offset(x: leftOffset)
                        .zIndex(1)
                    
                    Image(.ellipse2)
                        .frame(width: 100, height: 100)
                        .offset(x: rightOffset)
                        .zIndex(0)
                }
                .onAppear {
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: true)) {
                        leftOffset = 100
                        rightOffset = -100
                    }
                }
                Spacer()
                Text("Loading...")
                    .frame(maxWidth: .infinity)
                    .font(.custom("RobotoSerif-ExtraBold", size: 44))
                    .foregroundStyle(.white)
                    .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1.5)
                Spacer()
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(.onbBackground)
                    .resizable()
                    .ignoresSafeArea()
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isLoad = true
                }
            }
        }
    }
}

#Preview {
    OnboardingScreen()
}
