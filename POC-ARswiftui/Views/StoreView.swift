//
//  StoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI

struct StoreView: View {
    let pacotes: [PackageContent] = [PackageContent(name: "4 cartas grátis", imageName: "fire", price: 0, description: "Descubra os elementos a partir da água, terra, fogo e ar!", pdfName: "freeCards"), PackageContent(name: "Cartas premium", imageName: "water", price: 10, description: "Compre o pacote premium de 25 cartas e descubra todos os elementos do jogo", pdfName: "freeCards")]
    
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
                    ItemStoreView(name: pacote.name, imageName: pacote.imageName, price: pacote.price, description: pacote.description, pdfName: pacote.pdfName)
                }
            }
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
