//
//  CollectionGridView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct CollectionGridView: View {
    @Binding var openConquistas: Bool
    let elements: [CellContent] = [CellContent(color: Color.redElementar, name: "Fire", icon: Image("fireIcon")), CellContent(color: Color.blueElementar, name: "Water", icon: Image("waterIcon")), CellContent(color: Color.yellowElementar, name: "Air", icon: Image("airIcon")), CellContent(color: Color.greenElementar, name: "Dirt", icon: Image("earthIcon")), CellContent(color: Color.redElementar, name: "Lava", icon: Image("lavaIcon")), CellContent(color: Color.yellowElementar, name: "Dust", icon: Image("dustIcon")), CellContent(color: Color.greenElementar, name: "Mud", icon: Image("mudIcon")), CellContent(color: Color.yellowElementar, name: "Energy", icon: Image("energyIcon")), CellContent(color: Color.blueElementar, name: "Rain", icon: Image("rainIcon")), CellContent(color: Color.blueElementar, name: "Steam", icon: Image("vaporIcon")), CellContent(color: Color.blueElementar, name: "Stone", icon: Image("lavaIcon")), CellContent(color: Color.blueElementar, name: "Gunpowder", icon: Image("lavaIcon")), CellContent(color: Color.blueElementar, name: "Obsidian", icon: Image("waterIcon")), CellContent(color: Color.greenElementar, name: "Seed", icon: Image("earthIcon")), CellContent(color: Color.redElementar, name: "Sun", icon: Image("lavaIcon")), CellContent(color: Color.yellowElementar, name: "Moon", icon: Image("dustIcon")), CellContent(color: Color.greenElementar, name: "Crystal", icon: Image("mudIcon")), CellContent(color: Color.yellowElementar, name: "Sand", icon: Image("energyIcon")), CellContent(color: Color.blueElementar, name: "Metal", icon: Image("rainIcon")), CellContent(color: Color.blueElementar, name: "Rainbow", icon: Image("vaporIcon")), CellContent(color: Color.blueElementar, name: "Grass", icon: Image("lavaIcon")), CellContent(color: Color.redElementar, name: "Sapphire", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Emerald", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Earth", icon: Image("fireIcon")), CellContent(color: Color.blueElementar, name: "Ruby", icon: Image("lavaIcon")), CellContent(color: Color.redElementar, name: "Clay", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Glass", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Mercury", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Blade", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Tree", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Gold", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Sandstone", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Bomb", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Brick", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Cement", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Ice", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Mirror", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Wood", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Coal", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Snow", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Smoke", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Paper", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Steel", icon: Image("fireIcon")), CellContent(color: Color.redElementar, name: "Petroleum", icon: Image("fireIcon"))]
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
                    Text("Achievements")
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
