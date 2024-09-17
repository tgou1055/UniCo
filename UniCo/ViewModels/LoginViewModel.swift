//
//  LoginViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {}
    
    func login() {
        
        guard validate() else {
            return
        }
        //errorMessage = "Logging in..."
        
        // Try log user in...
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        
        // Non-empty login information
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
             !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please fill in all login information!"
            return false
        }
        
        // john@foo.com
        guard email.contains("@") && email.contains(".") else {
            
            errorMessage = "Please enter valid email address!"
            return false
        }
        
        return true
    }
    
}
