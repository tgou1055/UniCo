//
//  RegisterViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    init() {}
    
    func register() {
        guard validate() else{
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String){
        let newUser = User(
            id: id,
            name: name,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        
        // handle missing info
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
             !email.trimmingCharacters(in: .whitespaces).isEmpty,
             !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            return false
        }
        
        // john@foo.com
        guard email.contains("@") && email.contains(".") else {
            
            return false
        }
        
        // handle password length
        guard password.count >= 6 else {
            
            return false
        }
        
        return true
    }
    
    
}
