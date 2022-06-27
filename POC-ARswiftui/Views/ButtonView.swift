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
    
    init(systemIcon: String, size: CGFloat) {
        self.systemIcon = systemIcon
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Color.blackElementar
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
        ButtonView(systemIcon: "menucard.fill", size: 60)
            .previewLayout(.sizeThatFits)
    }
}
