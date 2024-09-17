//
//  RegisterView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct RegisterView: View {
    enum FocusedField {
        case name, email, pwd
    }
    @State var viewModel = RegisterViewModel()
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            //Header
            Header(
                    title: "Sign Up",
                    subtitle: "Uni life becomes easy!",
                    angle: 0,
                    background: .purple
            )
            .offset(y: 110)
            
            //Sign up form
            Form {
                
                // Enter info in text fields
                TextField("Full name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .name)
                
                TextField("Email address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .email)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .pwd)
                
//                SecureField("Confirm password", text: $password)
//                    .textFieldStyle(DefaultTextFieldStyle())
//                    .autocapitalization(.none)
//                    .autocorrectionDisabled()
                
                //Attempt register
                UButton(
                    title: "Register",
                    background: .green
                ) {
                    viewModel.register()
                }
            }
            .offset(y: -10)
            .frame(height: 700)
            
            Spacer()
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

#Preview {
    RegisterView()
}
