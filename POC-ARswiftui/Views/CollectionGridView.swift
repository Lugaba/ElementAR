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
                                   CellContent(color: Color.blueElementar, name: "Pedra", icon: Image("lavaIcon")),
                                   CellContent(color: Color.redElementar, name: "Pólvora", icon: Image("fireIcon")),
                                   CellContent(color: Color.blueElementar, name: "Obisidiana", icon: Image("waterIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Furacão", icon: Image("airIcon")),
                                   CellContent(color: Color.greenElementar, name: "Semente", icon: Image("earthIcon")),
                                   CellContent(color: Color.redElementar, name: "Sol", icon: Image("lavaIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Lua", icon: Image("dustIcon")),
                                   CellContent(color: Color.greenElementar, name: "Cristal", icon: Image("mudIcon")),
                                   CellContent(color: Color.yellowElementar, name: "Areia", icon: Image("energyIcon")),
                                   CellContent(color: Color.blueElementar, name: "Metal", icon: Image("rainIcon")),
                                   CellContent(color: Color.blueElementar, name: "Arco-Iris", icon: Image("vaporIcon")),
                                   CellContent(color: Color.blueElementar, name: "Grama", icon: Image("lavaIcon")),
                                   CellContent(color: Color.redElementar, name: "Safira", icon: Image("fireIcon")),
                                   CellContent(color: Color.redElementar, name: "Esmeralda", icon: Image("fireIcon")),
                                   CellContent(color: Color.redElementar, name: "PlanetaTerra", icon: Image("fireIcon")),
                                   CellContent(color: Color.blueElementar, name: "Rubi", icon: Image("lavaIcon"))

    ]
    let columns = [
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200))
    ]
    var indexFind = UserDefaults.standard.integer(forKey: "numberDiscovered")
    
    var body: some View {
        ZStack {
            let countElements = elements.count
            let numbersOfVStack = Int(ceil(Double(countElements)/9))
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
                    ForEach(1...numbersOfVStack, id: \.self) { id in
                        let start = 9 * (id-1)
                        let finish = 8 + (9 * (id-1))
                        if finish > countElements-1 {
                            VStack {
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach(Array(elements[start...countElements - 1])) { element in
                                        CollectionCellView(color: element.color, name: element.name, icon: element.icon, isUnlocked: UserDefaults.standard.bool(forKey: element.name))
                                    }
                                }.padding(20)
                            }
                        } else {
                            VStack {
                                LazyVGrid(columns: columns, spacing: 8) {
                                    ForEach(Array(elements[start...finish])) { element in
                                        CollectionCellView(color: element.color, name: element.name, icon: element.icon, isUnlocked: UserDefaults.standard.bool(forKey: element.name))
                                    }
                                }.padding(20)
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
