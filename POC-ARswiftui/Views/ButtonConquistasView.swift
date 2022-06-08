//
//  ButtonConquistasView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct ButtonConquistasView: View {
    var body: some View {
        ZStack {
            Color.blackElementar
            Image(systemName: "menucard.fill")
                .resizable()
                .scaledToFit()
                .padding(7)
                .foregroundColor(Color.whiteElementar)
            
        }
        .frame(width: 60, height: 60)
        .cornerRadius(10)
    }
}

struct ButtonConquistasView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConquistasView()
            .previewLayout(.sizeThatFits)
    }
}
