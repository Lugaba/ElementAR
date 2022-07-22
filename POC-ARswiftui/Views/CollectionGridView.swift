//
//  CollectionGridView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct CollectionGridView: View {
    @Binding var openConquistas: Bool
    let elements: [CellContent] = [CellContent(color: Color.redElementar, name: "Fire", icon: Image("fireIcon")), CellContent(color: Color.blueElementar, name: "Water", icon: Image("waterIcon")), CellContent(color: Color.yellowElementar, name: "Air", icon: Image("airIcon")), CellContent(color: Color.greenElementar, name: "Dirt", icon: Image("dirtIcon")), CellContent(color: Color.redElementar, name: "Lava", icon: Image("lavaIcon")), CellContent(color: Color.yellowElementar, name: "Dust", icon: Image("dustIcon")), CellContent(color: Color.greenElementar, name: "Mud", icon: Image("mudIcon")), CellContent(color: Color.yellowElementar, name: "Energy", icon: Image("energyIcon")), CellContent(color: Color.blueElementar, name: "Rain", icon: Image("rainIcon")), CellContent(color: Color.blueElementar, name: "Steam", icon: Image("vaporIcon")), CellContent(color: Color.redElementar, name: "Stone", icon: Image("stoneIcon")), CellContent(color: Color.redElementar, name: "Gunpowder", icon: Image("gunpowderIcon")), CellContent(color: Color.redElementar, name: "Obsidian", icon: Image("obsidianIcon")), CellContent(color: Color.greenElementar, name: "Seed", icon: Image("seedIcon")), CellContent(color: Color.yellowElementar, name: "Sun", icon: Image("sunIcon")), CellContent(color: Color.yellowElementar, name: "Moon", icon: Image("moonIcon")), CellContent(color: Color.yellowElementar, name: "Crystal", icon: Image("crystalIcon")), CellContent(color: Color.greenElementar, name: "Sand", icon: Image("sandIcon")), CellContent(color: Color.redElementar, name: "Metal", icon: Image("metalIcon")), CellContent(color: Color.blueElementar, name: "Rainbow", icon: Image("rainbowIcon")), CellContent(color: Color.greenElementar, name: "Grass", icon: Image("grassIcon")), CellContent(color: Color.blueElementar, name: "Sapphire", icon: Image("sapphireIcon")), CellContent(color: Color.greenElementar, name: "Emerald", icon: Image("emeraldIcon")), CellContent(color: Color.blueElementar, name: "Earth", icon: Image("earthIcon")), CellContent(color: Color.redElementar, name: "Ruby", icon: Image("rubyIcon")), CellContent(color: Color.greenElementar, name: "Clay", icon: Image("clayIcon")), CellContent(color: Color.yellowElementar, name: "Glass", icon: Image("glassIcon")), CellContent(color: Color.blueElementar, name: "Mercury", icon: Image("waterIcon")), CellContent(color: Color.redElementar, name: "Blade", icon: Image("bladeIcon")), CellContent(color: Color.greenElementar, name: "Tree", icon: Image("treeIcon")), CellContent(color: Color.redElementar, name: "Gold", icon: Image("metalIcon")), CellContent(color: Color.greenElementar, name: "Sandstone", icon: Image("sandstoneIcon")), CellContent(color: Color.redElementar, name: "Bomb", icon: Image("bombIcon")), CellContent(color: Color.greenElementar, name: "Brick", icon: Image("brickIcon")), CellContent(color: Color.greenElementar, name: "Cement", icon: Image("cementIcon")), CellContent(color: Color.blueElementar, name: "Ice", icon: Image("iceIcon")), CellContent(color: Color.greenElementar, name: "Wood", icon: Image("woodIcon")), CellContent(color: Color.redElementar, name: "Coal", icon: Image("coalIcon")), CellContent(color: Color.yellowElementar, name: "Snow", icon: Image("snowIcon")), CellContent(color: Color.redElementar, name: "Smoke", icon: Image("smokeIcon")), CellContent(color: Color.greenElementar, name: "Paper", icon: Image("paperIcon")), CellContent(color: Color.redElementar, name: "Steel", icon: Image("steelIcon")), CellContent(color: Color.blueElementar, name: "Petroleum", icon: Image("petroleumIcon"))]
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
