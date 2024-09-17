//
//  LoginView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct LoginView: View {
    enum FocusedField {
        case user, pwd
    }
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Header(
                    title: "Uni Co",
                    subtitle: "Tracking Uni Progress Made Simpler !",
                    angle: 0,
                    background: .teal
                )
                .offset(y: 100)
                
                // Login Form
                Form {
                    // Handle button press errors
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .focused($focusedField, equals: .user)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .focused($focusedField, equals: .pwd)
                    
                    // Attempt login
                    UButton(
                        title: "Log In",
                        background: .blue
                    ) {
                        viewModel.login()
                    }
                }
                .offset(y: -10)
                .frame(height: 500)
                
                Spacer()
                // Create Account option
                VStack {
                    Text("New user here?")
                        .bold()
                    NavigationLink("Create an account",
                                   destination: RegisterView())
                    .bold()
                }
                .padding(.bottom, 90)
                .ignoresSafeArea(.keyboard)
                
                
                Spacer() // push content to top of the screen
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                }
                ToolbarItem(placement: .keyboard) {
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
        
    }
}

#Preview {
    LoginView()
}
