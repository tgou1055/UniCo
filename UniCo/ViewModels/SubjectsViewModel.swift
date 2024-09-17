//
//  SubjectsViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseFirestore
import Foundation

// ViewModel for list of subjects
// Primary tab
class SubjectsViewModel: ObservableObject {
    @Published var showingNewSubjectView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    
    /// Delete a subject info in Subjects view.
    /// - Parameter id: <#id description#>
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("subjects")
            .document(id)
            .delete()
    }
}
