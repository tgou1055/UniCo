//
//  NewTaskView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 12/9/2024.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject var viewModel = NewTaskViewModel()
    @Binding var newTaskPresented: Bool // this variable binds with showingNewTaskView in parent view or parent view model
    
    // Is it okay to declare like this?
    let subjectId: String
    // Define the types of a task
    private let types = ["Assignment", "Exam", "Quiz", "Lab"]

    var body: some View {
        VStack{
            Text("Task Information")
                .font(.system(size: 26))
                .bold()
                .offset(y: 10)
            Form {
                // Type
                Picker("Type", selection: $viewModel.type) {
                    ForEach(types, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(DefaultDatePickerStyle()) // or change style
                
                // Weighting
                TextField("Weighting", text: $viewModel.weight)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.decimalPad)
                // Full Mark
                TextField("Full Mark", text: $viewModel.mark)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.decimalPad)
                // Score
                TextField("Score", text: $viewModel.score)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                // Button: Save
                UButton( title: "Save", background: .red){
                        // check 'can save' logic
                        if viewModel.canSave {
                            viewModel.subjectId = subjectId
                            viewModel.save()
                            newTaskPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                }
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields")
                )
            })
        }
    }
}

#Preview {
    NewTaskView(newTaskPresented: Binding(get: {
        return true
    }, set: { _ in
    }), subjectId: "363B361C-338E-47AE-A873-3608577A973A")
}
