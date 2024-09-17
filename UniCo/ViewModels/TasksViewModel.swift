//
//  TasksViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 10/9/2024.
//

import FirebaseFirestore
import Foundation

class TasksViewModel: ObservableObject {
    @Published var showingNewTaskView = false
    @Published var showingNewPredictionView = false
    
    let userId: String
    let subjectId: String
    let subjectTitle: String
    
    init(userId: String, subjectId: String, subjectTitle: String) {
        self.userId = userId
        self.subjectId = subjectId
        self.subjectTitle = subjectTitle
    }
    
    /// Delete a subject info in Subjects view.
    /// - Parameter id: <#id description#>
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("subjects")
            .document(subjectId)
            .collection("tasks")
            .document(id)
            .delete()
    }
}
