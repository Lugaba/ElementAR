//
//  ButtonPdf.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 16/06/22.
//

import SwiftUI

struct ButtonPdf: View {
    var body: some View {
        ZStack {
            Color.blackElementar
            Image(systemName: "printer.filled.and.paper")
                .resizable()
                .scaledToFit()
                .padding(7)
                .foregroundColor(Color.whiteElementar)
            
        }
        .frame(width: 60, height: 60)
        .cornerRadius(10)
    }
}

struct ButtonPdf_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPdf().previewLayout(.sizeThatFits)
    }
}
