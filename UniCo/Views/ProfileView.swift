//
//  ProfileView.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.featchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode:  .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        // Info: name, email, member since
        VStack(alignment: .leading){
            Form {
                HStack {
                    Text("Name: ")
                    Text(user.name)
                }
                HStack {
                    Text("Email: ")
                    Text(user.email)
                }
                HStack {
                    Text("Member Since: ")
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                }
                // Sign out
                UButton(title: "Logout", background: .red) {
                    viewModel.logOut()
                }
            }
        }
        Spacer()
    }
}

#Preview {
    ProfileView()
}
