//
//  TasksView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 10/9/2024.
//

import FirebaseFirestore
import SwiftUI

struct TasksView: View {
    @State private var navigateToEditTask = false
    @StateObject var viewModel: TasksViewModel
    @FirestoreQuery var Tasks: [Task]
    
    init (userId: String, subjectId: String, subjectTitle: String) {
        self._Tasks = FirestoreQuery(
            collectionPath: "users/\(userId)/subjects/\(subjectId)/tasks"
        )
        self._viewModel = StateObject(
            wrappedValue: TasksViewModel(userId: userId, subjectId: subjectId, subjectTitle: subjectTitle)
        )
    }
    
    var body: some View {
        VStack {
            // Subject Title
            HStack {
                Text(viewModel.subjectTitle)
                    .frame(maxWidth: 265, alignment: .leading)
                Button {
                    viewModel.showingNewPredictionView = true
                } label: {
                    HStack {
                        Text("Predict")  // Button label
                        Image(systemName: "brain").bold()
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingNewPredictionView) {
                NewPredictionView(newPredictionPresented: $viewModel.showingNewPredictionView, userId: viewModel.userId, subjectId: viewModel.subjectId) //show new prediction view
            }
            
            
            // List of Tasks
            List(Tasks.sorted(by: { $0.dueDate < $1.dueDate })){ task in
                TaskView(task: task, subjectId: viewModel.subjectId)
                    // Right side swip to delete
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            viewModel.delete(id: task.id)
                        } label: {
                            Text("Delete")
                        }
                    }
                    .tint(.pink)
            }
            .listStyle(SidebarListStyle())
            
            Spacer()
        }
        .navigationTitle("Tasks")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            Button {
                //Action
                viewModel.showingNewTaskView = true
            } label: {
                HStack {
                    Text("Add task")  // Button label
                    Image(systemName: "plus").bold()  // Button image
                }
            }
            .sheet(isPresented: $viewModel.showingNewTaskView) {
                NewTaskView(newTaskPresented: $viewModel.showingNewTaskView, subjectId: viewModel.subjectId) //show new subject view
            }
        }
        
        //Spacer()
    }
}

#Preview {
    TasksView(userId: "t0tXBi1pMZOiZfXrVtHG5Tiv0zY2", subjectId:"EFA7FA88-D370-41AA-8D7E-A7686A7326AA"
, subjectTitle: "Discrete Mathematics")
}
