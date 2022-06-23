//
//  CollectionGridView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct CollectionGridView: View {
    
    let elements: [CellContent] = [CellContent(color: Color.redElementar, name: "Fogo", icon: Image("fireIcon")),
                                   CellContent(color: Color.blueElementar, name: "Água", icon: Image("waterIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Ar", icon: Image("airIcon")),
                                   CellContent(color: Color.greenElementar, name: "Terra", icon: Image("earthIcon")),
                                   CellContent(color: Color.redElementar, name: "Lava", icon: Image("lavaIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Pó", icon: Image("dustIcon")),
                                   CellContent(color: Color.greenElementar, name: "Lama", icon: Image("mudIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Energia", icon: Image("energyIcon")),
                                   CellContent(color: Color.blueElementar, name: "Chuva", icon: Image("rainIcon")),
                                   CellContent(color: Color.blueElementar, name: "Vapor", icon: Image("vaporIcon")),
                                   CellContent(color: Color.blueElementar, name: "Pedra", icon: Image("lavaIcon"))
    ]
    let columns = [
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200))
    ]
    var body: some View {
        VStack(spacing: 0) {
            Text("Conquistas")
                .padding(.top)
                .font(.system(.largeTitle, design: .rounded))
            TabView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(Array(elements[0...8])) { element in
                            CollectionCellView(color: element.color, name: element.name, icon: element.icon, isUnlocked: UserDefaults.standard.bool(forKey: element.name))
                        }
                    }
                    
                }
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(elements[6...9])) { element in
                            CollectionCellView(color: element.color, name: element.name, icon: element.icon, isUnlocked: UserDefaults.standard.bool(forKey: element.name))
                        }
                        
                        Rectangle().fill(.clear)
                            .frame(width: 120, height: 120)
                        Rectangle().fill(.clear)
                            .frame(width: 120, height: 120)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .background(Color.blackElementar)

    }
}

struct CollectionGridView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionGridView()
    }
}
