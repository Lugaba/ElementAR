//
//  CollectionCellView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 07/06/22.
//

import SwiftUI

struct CollectionCellView: View {
    @State private var isUnlocked: Bool
    private var color: Color
    private var name: String
    private var icon: Image
    
    init(color: Color, name: String, icon: Image, isUnlocked: Bool) {
        self.color = color
        self.name = name
        self.icon = icon
        self.isUnlocked = isUnlocked
    }
    
    var body: some View {
        ZStack {
            color
            if !isUnlocked {
                Color.greyElementar
                Image("lockIcon")
                    .resizable()
                    .scaledToFit()
                    .padding() .padding()
            } else {
                VStack {
                    icon
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    Text(name)
                        .padding(.horizontal)
                        .background(Capsule().fill(Color.greyElementar))
                }   .font(.system(.title3, design: .rounded) .weight(.bold))
                    .foregroundColor(Color.whiteElementar)
                    .padding(.vertical)
            }
            
        }
        .frame(width: 100, height: 100)
        .cornerRadius(14)
    }
}

struct CollectionCellView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCellView(color: Color.yellowElementar, name: "Fogo", icon: Image("fireIcon"), isUnlocked: false)
            .padding()
            .previewLayout(.sizeThatFits)
            
    }
}
