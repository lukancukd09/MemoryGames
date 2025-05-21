
import SwiftUI

struct MainScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    @State var rectangleButtonWidth: CGFloat?
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Button {
                path.append(Router.profile)
            } label: {
                Image(.accButton)
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .trailing)
            
            Spacer()
            
            HStack(alignment: .bottom, spacing: 16) {
                Button {
                    path.append(Router.levels(.pairs))
                } label: {
                    Text("Find a\ncouple")
                        .foregroundColor(.white)
                        .font(.custom("RobotoSerif-Black", size: 38))
                        .customStroke(color: Color.init(redd: 39, greenn: 189, bluee: 114), width: 1)
                }
                .readSize {
                    rectangleButtonWidth = $0?.width
                }
                .frame(height: rectangleButtonWidth)
                .frame(maxWidth: .infinity)
                .background(
                    Image(.game1Button)
                        .resizable()
                        .scaledToFit()
                )
                
                Button {
                    path.append(Router.levels(.repeatMe))
                } label: {
                    Text("Memory")
                        .foregroundColor(.white)
                        .font(.custom("RobotoSerif-Black", size: 32))
                        .customStroke(color: Color.init(redd: 104, greenn: 47, bluee: 202), width: 1)
                }
                .frame(height: rectangleButtonWidth)
                .frame(maxWidth: .infinity)
                .readSize {
                    rectangleButtonWidth = $0?.width
                }
                .background(
                    Image(.game2Button)
                        .resizable()
                        .scaledToFit()
                )
            }
            
//            Spacer()
            
            Button {
                path.append(Router.info)
            } label: {
                Text("info")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 18)
            .background(RadialGradient(colors: [
                Color.init(redd: 246, greenn: 168, bluee: 64),
                Color.init(redd: 255, greenn: 100, bluee: 3)
            ], center: .top, startRadius: 1, endRadius: 60))
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 180, greenn: 78, bluee: 0), lineWidth: 16)
            )
            .clipShape(RoundedRectangle(cornerRadius: 70))
            
            Button {
                path.append(Router.settigs)
            } label: {
                Text("Settings")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 18)
            .background(RadialGradient(colors: [
                Color.init(redd: 246, greenn: 168, bluee: 64),
                Color.init(redd: 255, greenn: 100, bluee: 3)
            ], center: .top, startRadius: 1, endRadius: 60))
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 180, greenn: 78, bluee: 0), lineWidth: 16)
            )
            .clipShape(RoundedRectangle(cornerRadius: 70))
            .padding(.top, 8)
            .padding(.bottom, 40)
            

        }
        .padding(.horizontal, 16)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .background(
            Image(.mainMainBackground)
                .resizable()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MainScreen(path: .constant(.init()))
}
