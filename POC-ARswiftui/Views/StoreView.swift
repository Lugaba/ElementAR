//
//  StoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI

struct StoreView: View {
    let pacotes: [PackageContent] = [PackageContent(name: "Free", imageName: "fire", price: 0, description: "Descubra os elementos a partir da água, terra, fogo e ar!", pdfName: "freeCards", isBought: true, isAvailable: true), PackageContent(name: "Elements", imageName: "water", price: 10, description: "Compre o pacote premium de 25 cartas e descubra todos os elementos do jogo", pdfName: "freeCards", isBought: UserDefaults.standard.bool(forKey: "*ID of IAP Product*"), isAvailable: true), PackageContent(name: "Animals", imageName: "water", price: 10, description: "Compre o pacote premium de 25 cartas e descubra todos os animais do jogo", pdfName: "freeCards", isBought: false, isAvailable: false), PackageContent(name: "Fantasy", imageName: "water", price: 10, description: "Compre o pacote premium de 25 cartas e descubra todos os animais do jogo", pdfName: "freeCards", isBought: false, isAvailable: false)]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Text("⚠️ Você precisa de uma impressora ⚠️")
                    .padding()
                    .background(.yellow.opacity(0.8))
                    .cornerRadius(15)
                    .padding(.top, 20)
                    .font(.system(.body, design: .rounded))

                    
                ForEach(Array(pacotes)) { pacote in
                    ItemStoreView(name: pacote.name, imageName: pacote.imageName, price: pacote.price, description: pacote.description, pdfName: pacote.pdfName, isBought: pacote.isBought, isAvailable: pacote.isAvailable)
                }
            }
        }
        .navigationTitle("Store")
        .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //Restore products already purchased
                    }) {
                        Text("Restore Purchases ")
                    }
                }
            })
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
