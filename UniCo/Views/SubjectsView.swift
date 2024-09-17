//
//  SubjectsView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import FirebaseFirestore
import SwiftUI

struct SubjectsView: View {
    @StateObject var viewModel: SubjectsViewModel
    @FirestoreQuery var Subjects: [Subject]
    
    init (userId: String) {
        self._Subjects = FirestoreQuery(
            collectionPath: "users/\(userId)/subjects"
        )
        self._viewModel = StateObject(
            wrappedValue: SubjectsViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Manage Subjects Information")
                    .frame(maxWidth: 355, alignment: .leading)
                
                List(Subjects){ subject in
                    //Text(Subject.code + " - " + Subject.title)
                    SubjectView(subject: subject)
                        .swipeActions {
                            Button {
                                viewModel.delete(id: subject.id)
                            } label: {
                                Text("Delete")
                            }
                        }
                        .tint(.pink)
                }
                .listStyle(SidebarListStyle())
                .offset(y: 0)
            }
            .navigationTitle("Subjects")
            .toolbar {
                Button {
                    //Action
                    viewModel.showingNewSubjectView = true
                } label: {
                    HStack {
                        Text("Add subject")  // Button label
                        Image(systemName: "plus").bold()  // Button image
                    }
                }
                .sheet(isPresented: $viewModel.showingNewSubjectView) {
                    NewSubjectView(newSubjectPresented: $viewModel.showingNewSubjectView) //show new Subject view
                }
                .offset(y: 0)
            }
        }.offset(y: -50)
    }
}

#Preview {
    SubjectsView(userId: "t0tXBi1pMZOiZfXrVtHG5Tiv0zY2")
}
