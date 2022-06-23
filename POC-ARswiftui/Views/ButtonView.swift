//
//  ButtonConquistasView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct ButtonView: View {
    private var systemIcon: String
    
    init(systemIcon: String) {
        self.systemIcon = systemIcon
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
        .frame(width: 60, height: 60)
        .cornerRadius(10)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(systemIcon: "menucard.fill")
            .previewLayout(.sizeThatFits)
    }
}
