
import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    @StateObject private var viewModel: ProfileViewModel
    @ObservedObject var authMain: AuthMain
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @State private var showingImagePicker = false
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var isPresentAlert = false
    
    init(viewModel: ProfileViewModel, authMain: AuthMain, path: Binding<NavigationPath>) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.authMain = authMain
        self._path = path
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(.backButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                Spacer()
                Text("Profile")
                    .frame(maxWidth: .infinity)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .foregroundStyle(.white)
                    .textCase(.uppercase)
                    .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                    .padding(.trailing, 80)
                Spacer()
            }
            
            if let image = viewModel.displayImage {
                ZStack(alignment: .bottom) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.init(redd: 104, greenn: 47, bluee: 202), lineWidth: 8)
                        )
                    
                    Text(authMain.currentuser?.name ?? "Anonimous")
                        .frame(maxWidth: .infinity)
                        .font(.custom("RobotoSerif-Black", size: 28))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .customStroke(color: Color.init(redd: 104, greenn: 47, bluee: 202), width: 1)
                        .padding(.bottom, 30)
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                .padding(.top, 20)
            } else {
                ZStack(alignment: .bottom) {
                    Image(.profileIcon)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.init(redd: 104, greenn: 47, bluee: 202), lineWidth: 8)
                        )

                    Text(authMain.currentuser?.name ?? "Anonimous")
                        .frame(maxWidth: .infinity)
                        .font(.custom("RobotoSerif-Black", size: 28))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .customStroke(color: Color.init(redd: 104, greenn: 47, bluee: 202), width: 1)
                        .padding(.bottom, 30)
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                .padding(.top, 20)
            }

            Spacer()
            
            Button {
                authMain.signOut()
                viewModel.deleteAcc()
                dismiss()
            } label: {
                Text("Log out")
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
//                viewModel.deleteAcc()
                isPresentAlert = true
            } label: {
                Text("Delete account")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 18)
            .background(RadialGradient(colors: [
                Color.init(redd: 246, greenn: 140, bluee: 64),
                Color.init(redd: 255, greenn: 45, bluee: 3)
            ], center: .top, startRadius: 1, endRadius: 60))
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 180, greenn: 33, bluee: 0), lineWidth: 16)
            )
            .clipShape(RoundedRectangle(cornerRadius: 70))
            .padding(.top, 8)
            .padding(.bottom, 40)
            .alert("Are you sure?", isPresented: $isPresentAlert) {
                Button("Delete", role: .destructive) {
                    authMain.deleteUserAccount { result in
                        switch result {
                        case .success():
                            print("Account deleted successfully.")
                            viewModel.deleteAcc()
                            authMain.userSession = nil
                            authMain.currentuser = nil
                            dismiss()
                        case .failure(let error):
                            print("ERROR DELELETING: \(error.localizedDescription)")
                        }
                    }
                }
                Button("Cancel", role: .cancel) {
                    
                }
            } message: {
                Text("Are you sure you want to delete the account?")
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.mainBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .photosPicker(
            isPresented: $showingImagePicker,
            selection: $selectedImage,
            matching: .images,
            photoLibrary: .shared()
        )
        .task(id: selectedImage) {
            if let item = selectedImage {
                await viewModel.saveProfileImageAsync(item: item)
                selectedImage = nil
            }
        }
    }
}

#Preview {
    ProfileScreen(viewModel: .init(), authMain: .init(), path: .constant(.init()))
}
