

import SwiftUI

extension AuthorizationScreen: AuthProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
    }
}

struct AuthorizationScreen: View {
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @ObservedObject var viewModel: AuthMain
    @State private var isAuth = true
    
    // Используем enum для управления различными типами алертов
    enum AlertType {
        case error(String)
        case validation
        case none
    }
    
    @State private var alertType: AlertType = .none
    @State private var showAlert = false
    
    @Namespace private var animation
    
    @Binding var path: NavigationPath
    
    init(viewModel: AuthMain, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(isAuth ? "Log in" : "Registration")
                .frame(maxWidth: .infinity)
                .font(.custom("RobotoSerif-Black", size: 44))
                .foregroundStyle(.white)
                .customStroke(color: Color.init(redd: 220, greenn: 136, bluee: 33), width: 1)
                .id(isAuth ? "login_title" : "registration_title")
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut, value: isAuth)
            
            if !isAuth {
                TextField("", text: $name, prompt:
                            Text("Name")
                                .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
                                .font(.custom("RobotoSerif-Medium", size: 24))
                )
                .font(.custom("RobotoSerif-Medium", size: 24))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
                .background(.white)
                .cornerRadius(70)
                .overlay(
                    RoundedRectangle(cornerRadius: 70)
                        .stroke(Color.init(redd: 229, greenn: 122, bluee: 16), lineWidth: 2)
                )
                .padding(.top, 40)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            TextField("", text: $email, prompt:
                        Text("Email")
                            .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
                            .font(.custom("RobotoSerif-Medium", size: 24))
            )
            .font(.custom("RobotoSerif-Medium", size: 24))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
            .background(.white)
            .cornerRadius(70)
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 229, greenn: 122, bluee: 16), lineWidth: 2)
            )
            .padding(.top, isAuth ? 40 : 4)
            .matchedGeometryEffect(id: "emailField", in: animation)

            SecureField("", text: $password, prompt:
                            Text("Password")
                                .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
                                .font(.custom("RobotoSerif-Medium", size: 24))
            )
            .font(.custom("RobotoSerif-Medium", size: 24))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
            .background(.white)
            .cornerRadius(70)
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 229, greenn: 122, bluee: 16), lineWidth: 2)
            )
            .padding(.top, 4)
            .matchedGeometryEffect(id: "passwordField", in: animation)
            
            if !isAuth {
                SecureField("", text: $confirmPassword, prompt:
                                Text("Confirm password")
                                .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
                                .font(.custom("RobotoSerif-Medium", size: 24))
                )
                .font(.custom("RobotoSerif-Medium", size: 24))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .foregroundColor(Color.init(redd: 255, greenn: 166, bluee: 56))
                .background(.white)
                .cornerRadius(70)
                .overlay(
                    RoundedRectangle(cornerRadius: 70)
                        .stroke(Color.init(redd: 229, greenn: 122, bluee: 16), lineWidth: 2)
                )
                .padding(.top, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            Button {
                if isAuth {
                    Task {
                        do {
                            try await viewModel.signIn(email: email, password: password)
                            if !viewModel.text.isEmpty {
                                alertType = .error(viewModel.text)
                                showAlert = true
                            }
                        } catch {
                            alertType = .error(viewModel.text)
                            showAlert = true
                        }
                    }
                } else {
                    if isFormValid {
                        Task {
                            do {
                                try await viewModel.createUser(withEmail: email, password: password, name: name)
                                if !viewModel.text.isEmpty {
                                    alertType = .error(viewModel.text)
                                    showAlert = true
                                }
                            } catch {
                                alertType = .error(viewModel.text)
                                showAlert = true
                            }
                        }
                    } else {
                        alertType = .validation
                        showAlert = true
                    }
                }
            } label: {
                Text(isAuth ? "Log in" : "Create an account")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 18)
            .background(RadialGradient(colors: [
                Color.init(redd: 246, greenn: 98, bluee: 64),
                Color.init(redd: 210, greenn: 56, bluee: 56)
            ], center: .top, startRadius: 1, endRadius: 80))
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 255, greenn: 122, bluee: 122), lineWidth: 4)
            )
            .clipShape(RoundedRectangle(cornerRadius: 70))
            .padding(.top, 16)
            .transition(.scale.combined(with: .opacity))
            .id(isAuth ? "loginButton" : "registerButton")
            
            Text("or try this")
                .frame(maxWidth: .infinity)
                .font(.custom("RobotoSerif-Medium", size: 32))
                .foregroundStyle(.white)
                .shadow(color: .init(redd: 171, greenn: 56, bluee: 1), radius: 2, x: 0, y: 0)
                .padding(.top, 20)
        
            Button {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isAuth.toggle()
                }
            } label: {
                Text(isAuth ? "Create an account" : "Log in")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.init(redd: 246, greenn: 98, bluee: 64))
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 18)
            .background(Color.init(redd: 255, greenn: 202, bluee: 136))
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 246, greenn: 98, bluee: 64), lineWidth: 6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 70))
            .cornerRadius(70)
            .padding(.top, 20)
            .transition(.scale.combined(with: .opacity))
            .id(isAuth ? "createAccountButton" : "loginButton")
            
            Button {
                Task {
                    await viewModel.signInAnonymously()
                }
            } label: {
                Text("Anonimous")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.init(redd: 246, greenn: 98, bluee: 64))
                    .font(.custom("RobotoSerif-Black", size: 28))
                    .textCase(.uppercase)
            }
            .padding(.vertical, 18)
            .background(Color.init(redd: 255, greenn: 202, bluee: 136))
            .overlay(
                RoundedRectangle(cornerRadius: 70)
                    .stroke(Color.init(redd: 246, greenn: 98, bluee: 64), lineWidth: 6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 70))
            .cornerRadius(70)
            .padding(.top, 8)
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.authBackground)
                .resizable()
                .ignoresSafeArea()
        )
        .alert(isPresented: $showAlert) {
            switch alertType {
            case .error(let message):
                return Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .cancel()
                )
            case .validation:
                return Alert(
                    title: Text("Error"),
                    message: Text("Please ensure your email address is valid and not empty, your password is at least 6 characters long, and your confirmation password matches your password."),
                    dismissButton: .cancel()
                )
            case .none:
                return Alert(
                    title: Text("Error"),
                    message: Text("An unknown error occurred"),
                    dismissButton: .cancel()
                )
            }
        }
    }
}
#Preview {
    AuthorizationScreen(viewModel: .init(), path: .constant(.init()))
}
