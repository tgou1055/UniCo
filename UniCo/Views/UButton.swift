//
//  UButton.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct UButton: View {
    
    let title: String
    let background: Color
    let action: () -> Void  // define a function which returns 'Void'
    
    var body: some View {
        Button {
            action() //call action() while pressing button
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }.padding()
    }
}

#Preview {
    UButton(
        title: "Login",
        background: .blue
    ) {
        // Action
    }
}
