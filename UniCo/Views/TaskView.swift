//
//  TaskView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 12/9/2024.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel = MainViewModel()
    let task: Task
    let subjectId: String
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                NavigationLink(destination: EditTaskView(task: task, subjectId: subjectId)) {Text(task.type + " - " + task.title)
                        .font(.body)
                        .bold()
                }
                
                Spacer().frame(height: 10)
                
                Text("Subject Weighting: " + task.weighting)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                
                Text("Total Mark: " + task.mark)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                
                Text("Score: " + task.score)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                
                Spacer().frame(height: 10)
                
                Text("Due Date: " + "\(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                
                
            }
            Spacer()
            
//            Button {
//                viewModel.toggleIsDone(Subject: Subject)
//            } label: {
//                Image(systemName: Subject.isDone ? "checkmark.circle.fill" : "circle")
//            }
        }
       
    }
}



#Preview {
    TaskView(task: .init(id: "123", type: "Assignment", title: "Assignment 1", dueDate: 1727690340, weighting: "50", mark: "100", score: "99", isDone: true), subjectId: "")
}
