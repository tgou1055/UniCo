//
//  EditTaskView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 13/9/2024.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct EditTaskView: View {
    enum FocusedField {
        case title, weight, mark, score
    }
    
    @StateObject var viewModel: EditTaskViewModel
    @FocusState private var focusedField: FocusedField?
    @Environment(\.presentationMode) var presentationMode
 
    init(task: Task, subjectId: String) {
        self._viewModel = StateObject(
            wrappedValue: EditTaskViewModel(task: task, subjectId: subjectId)
        )
    }

    private let types = ["Assignment", "Exam", "Quiz", "Lab"]
    
    var body: some View {
        VStack{
            Form {
                // Type
                Picker("Type:", selection: $viewModel.type) {
                    ForEach(types, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                HStack {
                    Text("Title:")
                        .font(.subheadline)
                        .frame(width: 40, alignment: .leading)
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .focused($focusedField, equals: .title)
                }
                
                // Due Date
                DatePicker("Due Date:", selection: $viewModel.dueDate)
                    .frame(width: 300, alignment: .leading)
                    .datePickerStyle(DefaultDatePickerStyle()) // or change style
                
                // Weighting
                HStack {
                    Text("Weighting (%): ")
                        .font(.subheadline)
                        .frame(width: 110, alignment: .leading)
                    TextField("Weighting", text: $viewModel.weight)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .focused($focusedField, equals: .weight)
                        .keyboardType(.decimalPad)
                }
                // Full Mark
                HStack {
                    Text("Total Mark: ")
                        .font(.subheadline)
                        .frame(width: 80, alignment: .leading)
                    TextField("Total Mark", text: $viewModel.mark)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .focused($focusedField, equals: .mark)
                        .keyboardType(.decimalPad)
                }
                // Score
                HStack {
                    Text("Score: ")
                        .font(.subheadline)
                        .frame(width: 50, alignment: .leading)
                    TextField("Score", text: $viewModel.score)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .focused($focusedField, equals: .score)
                        .keyboardType(.decimalPad)
                }
                
                // Button: Save
                UButton( title: "Save", background: .red){
                        //test
                        presentationMode.wrappedValue.dismiss()
                        // check 'can save' logic
                    if viewModel.canSave {
                        viewModel.update()
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
            
            //push content to the top
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Spacer()
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = nil
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
        .navigationTitle("Edit Task Information")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditTaskView(task: .init(id: "123", type: "Assignment", title: "Assignment 1", dueDate: 1727690340, weighting: "50", mark: "100", score: "99", isDone: true), subjectId:"EFA7FA88-D370-41AA-8D7E-A7686A7326AA" )
}
