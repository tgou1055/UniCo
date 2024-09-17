//
//  MainViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseAuth
import Foundation

class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        let handler = Auth.auth().addStateDidChangeListener {[weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
