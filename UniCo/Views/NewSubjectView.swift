//
//  NewSubjectView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct NewSubjectView: View {
    @StateObject var viewModel = NewSubjectViewModel()
    @Binding var newSubjectPresented: Bool // this variable binds with showingNewSubjectView in parent view or parent view model
    
    // Define an array of years from 2024 to 2000
    private let years = Array(stride(from: 2024, through: 2010, by: -1))
    
    // Define an array of study sessions
    private let sessions = ["Autum", "Spring", "Summer", "Winter"]
    
    
    var body: some View {
        VStack{
            Text("Subject Information")
                .font(.system(size:26))
                .bold()
                .offset(y: 10)
            
            Form {
                
                // Subject code
                TextField("Subject Code", text: $viewModel.code)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .keyboardType(.numberPad)
                // Subject title
                TextField("Subject Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Select Year
                Picker("Year", selection: $viewModel.selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(viewModel.formatNumber(year)).tag(year)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                // Select Semester Session
                Picker("Session", selection: $viewModel.selectedSession) {
                    ForEach(sessions, id: \.self) { session in
                        Text(session).tag(session)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                // Button: Save
                UButton( title: "Save", background: .pink){
                        // check 'can save' logic
                        if viewModel.canSave {
                            viewModel.save()
                            newSubjectPresented = false
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
    NewSubjectView(newSubjectPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
