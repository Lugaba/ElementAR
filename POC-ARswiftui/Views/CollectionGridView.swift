//
//  CollectionGridView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct CollectionGridView: View {
    @Binding var openConquistas: Bool
    let elements: [CellContent] = [CellContent(color: Color.redElementar, name: "Fogo", icon: Image("fireIcon")),
                                   CellContent(color: Color.blueElementar, name: "Agua", icon: Image("waterIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Ar", icon: Image("airIcon")),
                                   CellContent(color: Color.greenElementar, name: "Terra", icon: Image("earthIcon")),
                                   CellContent(color: Color.redElementar, name: "Lava", icon: Image("lavaIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Poeira", icon: Image("dustIcon")),
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
    var indexFind = UserDefaults.standard.integer(forKey: "numberDiscovered")
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Conquistas")
                        .padding(.top)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                }
                Text("\(indexFind)/\(elements.count)")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
                TabView {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(Array(elements[0...8])) { element in
                                CollectionCellView(color: element.color, name: element.name, icon: element.icon, isUnlocked: UserDefaults.standard.bool(forKey: element.name))
                            }
                        }.padding(20)
                    }
                    VStack {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(Array(elements[9...elements.count-1])) { element in
                                CollectionCellView(color: element.color, name: element.name, icon: element.icon, isUnlocked: UserDefaults.standard.bool(forKey: element.name))
                            }
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
            .background(Color.blackElementar)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {openConquistas.toggle()}) {
                        Image(systemName: "x.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }.padding(16)
                }
                Spacer()
            }
            
            
        }
        

    }
}
