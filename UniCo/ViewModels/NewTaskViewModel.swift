//
//  NewTaskViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 12/9/2024.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class NewTaskViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var type: String = "Assignment"
    @Published var title: String = ""
    @Published var dueDate = Date()
    
    @Published var weight: String = ""
    @Published var mark: String = ""
    @Published var score: String = ""
    
    @Published var showAlert: Bool = false
    
    // pass in subjectID
    var subjectId: String = ""
    
//    init(subjectId: String) {
//        self.subjectId = subjectId
//    }
    
    init() {}
    
    func save() {
        //Assert canSave logic
        guard canSave else {
            return
        }
        // Get current user id   (currentUser? means it can be nil (empty))
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        // Create (data) model
        let taskId = UUID().uuidString
        let newTask = Task(
            id: taskId,
            type: type,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            weighting: weight,
            mark: mark,
            score: score,
            isDone: false
        )
        
        // Save (data) model
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("subjects")
            .document(subjectId) //temp
            .collection("tasks")
            .document(taskId)
            .setData(newTask.asDictionary()) //dict
        
    }
    
    var canSave: Bool {
        
        return true
    }
}
