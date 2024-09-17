//
//  NewPredictionView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 16/9/2024.
//

import FirebaseFirestore
import SwiftUI

struct NewPredictionView: View {
    @StateObject var viewModel: NewPredictionViewModel
    @Binding var newPredictionPresented: Bool
    @FirestoreQuery var tasks: [Task]
    @State private var isButtonDisabled = false
    
    //define subject id
    
    init (newPredictionPresented: Binding<Bool>, userId: String, subjectId: String) {
        self._tasks = FirestoreQuery(
            collectionPath: "users/\(userId)/subjects/\(subjectId)/tasks"
        )
        self._newPredictionPresented = Binding(get: {
            return false }, set: { _ in})
        
        self._viewModel = StateObject(
            wrappedValue: NewPredictionViewModel(userId: userId, subjectId: subjectId)
        )
    }
    

    var body: some View {
        VStack {
            Text("Prediction Information")
                .font(.system(size:26))
                .bold()
                .offset(y: 10)
            
            Form {
                Text("Input expected final grade and predict:")
                                .font(.headline)
                                .padding(.bottom, 10)
                HStack {
                    Text("Expectation (%):")
                        .font(.subheadline)
                        .frame(width: 120, alignment: .leading)
                    TextField("Input value", text: $viewModel.expectedGrade)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .disabled(isButtonDisabled)
                        .opacity(isButtonDisabled ? 0.5 : 1.0)
                }
                // Predict
                UButton( title: "Predict", background: .green){
                    // check logic
                    viewModel.showPredictions = true
                    isButtonDisabled = true
                }
            } //Form
            
            if viewModel.showPredictions {
                Text("To be able to achieve \(viewModel.expectedGrade) percent, you need: ")
                
                List(viewModel.predict(tasks: tasks).sorted(by: { $0.dueDate < $1.dueDate })){ task in
                    TaskView(task: task, subjectId: viewModel.subjectId)
                }
                .listStyle(SidebarListStyle())
            }
            
            Spacer()
            
        }//VStack
    }
}

#Preview {
    NewPredictionView(newPredictionPresented: Binding(get: {
        return true }, set: { _ in}), userId: "t0tXBi1pMZOiZfXrVtHG5Tiv0zY2",  subjectId: "EFA7FA88-D370-41AA-8D7E-A7686A7326AA")
}
