//
//  Header.swift
//  UniCo
//
//  Created by Tianpeng Gou on 8/9/2024.
//

import SwiftUI

struct Header: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            
            VStack {
                Text(title)
                    .font(.system(size: 45))
                    .foregroundColor(Color.white)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 23))
                    .foregroundColor(Color.white)
            }
            .padding(.top, 30)
        }
        .frame(width: UIScreen.main.bounds.width * 3,
              height: 330)
        .offset(y: -95)
    }
}

#Preview {
    Header(
            title: "Title",
            subtitle: "Subtitle",
            angle: 0,
            background: .blue
    )
}
