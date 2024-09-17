//
//  NewPredictionViewModel.swift
//  UniCo
//
//  Created by Tianpeng Gou on 16/9/2024.
//


import FirebaseAuth
import Foundation
import FirebaseFirestore

class NewPredictionViewModel: ObservableObject {
    @Published var expectedGrade = ""
    @Published var testValue = ""
    @Published var showPredictions = false
    
    let userId: String
    let subjectId: String
    //@FirestoreQuery var tasks: [Task]
    
    init(userId: String, subjectId: String) {
        self.subjectId = subjectId
        self.userId = userId
//        self._tasks = FirestoreQuery(
//            collectionPath: "users/\(self.userId)/subjects/\(self.subjectId)/tasks"
//        )
    }
    
    var canSave: Bool {
        return true
    }
    
    func predict(tasks: [Task]) -> [Task] {
        var tasksDone = tasks
        var tasksUndone = tasks
        
        var weightDone = 0.0
        var weightUndone = 0.0
        var weightsObtained = 0.0
        var weightsNeeded = 0.0
        
        // remove the task with 'score' zero!
        tasksDone = tasksDone.filter {$0.score != "0" }
        // remove the tasks already done
        tasksUndone = tasksUndone.filter {$0.score == "0"}
        
        // Calculate the total weights obtained
        for task in tasksDone {
            weightsObtained += Double(task.weighting)! * Double(task.score)! / Double(task.mark)!
            weightDone += Double(task.weighting)!
        }
        
        // Calculate the weight undone
        weightUndone = 100 - weightDone
        
        // Calculate the total weights needed
        if expectedGrade == "" {
            expectedGrade = "0"
        } else {
            weightsNeeded = Double(expectedGrade)! - weightsObtained
        }
        
        var tasksOutput: [Task] = []
        
        for task in tasksUndone {
            let weight = (weightsNeeded * (Double(task.weighting)! / weightUndone))
            let score = weight / Double(task.weighting)! * Double(task.mark)!

            tasksOutput += [Task(id: task.id, type: task.type, title: task.title, dueDate: task.dueDate, weighting: task.weighting, mark: task.mark, score: String(format: "%.3f", score), isDone: task.isDone)]
            
        }
        
        return tasksOutput
    }
}
