//
//  newPredictView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 16/9/2024.
//

import SwiftUI

struct NewPredictView: View {
    @StateObject var viewModel = NewPredictViewModel()
    @Binding var newPredictPresented: Bool
    
    
    var body: some View {
        VStack {
            Text("Prediction Information")
                .font(.system(size:26))
                .bold()
                .offset(y: 10)
            
            Form {
                Text("Input expected grade and predict:")
                                .font(.headline)
                                .padding(.bottom, 10)
                HStack {
                    Text("Expectation (%):")
                        .font(.subheadline)
                        .frame(width: 120, alignment: .leading)
                    TextField("Input value", text: $viewModel.expectedGrade)
                        .textFieldStyle(DefaultTextFieldStyle())
                }
                UButton( title: "Predict", background: .pink){
                        // check 'can save' logic
                        if viewModel.canSave {
                            viewModel.save()
                            newPredictPresented = false
                        } else {
                            //viewModel.showAlert = true
                        }
                }
            }
        }
    }
}

#Preview {
    NewPredictView(newPredictPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
