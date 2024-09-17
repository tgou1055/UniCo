//
//  ItemViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation


// View Model for a single subject item (each row of subjects list)
class SubjectViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(subject: Subject) {
        var subjectCopy = subject
        subjectCopy.setDone(!subject.isDone)
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // we update the isDone attribute.
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("subjects")
            .document(subjectCopy.id)
            .setData(subjectCopy.asDictionary())
        
    }
}
