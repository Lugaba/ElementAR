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
                        .padding(.bottom, 10)
                    Spacer()
                    Text(name)
                        .padding(.horizontal)
                        .background(Capsule().fill(Color.greyElementar))
                } .font(.title3 .weight(.bold))
                    .foregroundColor(Color.whiteElementar)
                    .padding(.vertical)
            }
            
        }
        .frame(width: 120, height: 120)
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
