//
//  NewSubjectViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewSubjectViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var title: String = ""
    @Published var selectedYear: Int = 2024
    @Published var selectedSession: String = "Autum"
    
    @Published var showAlert: Bool = false
    
    // initialise new instance
    init() {}
    
    // Remove thousands separators in large numbers.
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none // No special formatting
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    // Save the subject information to FirebaseStore
    func save() {
        guard canSave else {
            return
        }
        
        // Get current user id   (currentUser? means it can be nil (empty))
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create (data) model
        let SubjectId = UUID().uuidString
        let newSubject = Subject(
            id: SubjectId,
            code: code,
            title: title,
            selectedYear: formatNumber(selectedYear),
            selectedSession: selectedSession,
            isDone: false
        )
        
        // Save (data) model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("subjects")
            .document(SubjectId) //temp
            .setData(newSubject.asDictionary()) //dict
    }
    
    // 'can save' logic
    
    var canSave: Bool {
        guard !code.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // '86400' is number of seconds in a day
//        guard dueDate >= Date().addingTimeInterval(-86400) else {
//            return false
//        }
        
        return true
    }

    
   
}
