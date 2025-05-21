
import SwiftUI

struct FinishScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Pause")
                .frame(maxWidth: .infinity)
                .font(.custom("RobotoSerif-Black", size: 64))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .customStroke(color: Color.init(redd: 113, greenn: 56, bluee: 210), width: 1)
            
            Button {
                
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

#Preview {
    FinishScreen()
}
