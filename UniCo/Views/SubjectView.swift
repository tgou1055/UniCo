//
//  SubjectView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct SubjectView: View {
    @StateObject var viewModel = MainViewModel()
    let subject: Subject  //maychange to var? 'let' is immutatable once assigned
    
    var body: some View {
        HStack{
            VStack (alignment: .leading){
                NavigationLink(destination: TasksView(userId: viewModel.currentUserId, subjectId: subject.id, subjectTitle: subject.title)) {
                Text(subject.code + " - " + subject.title)
                    .font(.body)
                    .bold()
                }
                Text(subject.selectedSession + " - " + subject.selectedYear)
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
        }
//            Button {
//                viewModel.toggleIsDone(Subject: Subject)
//            } label: {
//                Image(systemName: Subject.isDone ? "checkmark.circle.fill" : "circle")
//            }
       
    }
}

#Preview {
    SubjectView(subject: .init(id: "123", code: "60117", title: "Data Analysis", selectedYear: "2024", selectedSession: "Spring", isDone: true))
}
