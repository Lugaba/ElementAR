//
//  ButtonConquistasView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct ButtonView: View {
    private var systemIcon: String
    private var size: CGFloat
    private var color: Color
    
    init(systemIcon: String, size: CGFloat, color: Color) {
        self.systemIcon = systemIcon
        self.size = size
        self.color = color
    }
    
    var body: some View {
        ZStack {
            color
            Image(systemName: systemIcon)
                .resizable()
                .scaledToFit()
                .padding(7)
                .foregroundColor(Color.whiteElementar)
            
        }
        .frame(width: size, height: size)
        .cornerRadius(10)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(systemIcon: "menucard.fill", size: 60, color: Color.blackElementar)
            .previewLayout(.sizeThatFits)
    }
}
