//
//  EditTaskViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 13/9/2024.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation


class EditTaskViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var type: String = ""
    @Published var title: String = ""
    @Published var dueDate = Date()
    
    @Published var weight: String = ""
    @Published var mark: String = ""
    @Published var score: String = ""
    
    @Published var isDone: Bool = false
    
    @Published var showAlert: Bool = false
    
    let task: Task
    let subjectId: String
    
    init(task: Task, subjectId: String) {
        self.task = task
        self.id = task.id
        self.type = task.type
        self.title = task.title
        self.dueDate = Date(timeIntervalSince1970: task.dueDate)
        self.weight = task.weighting
        self.mark = task.mark
        self.score = task.score
        
        self.subjectId = subjectId
    }
    

    func update() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // we update the isDone attribute.
        let db = Firestore.firestore()
        
        let taskUpdate = Task(id: id, type: type, title: title, dueDate: dueDate.timeIntervalSince1970, weighting: weight, mark: mark, score: score, isDone: isDone)
        
        db.collection("users")
            .document(userId)
            .collection("subjects")
            .document(subjectId)
            .collection("tasks")
            .document(id)
            .setData(taskUpdate.asDictionary())
    }
    
    var canSave: Bool {
        return true // for now
    }
    
}
