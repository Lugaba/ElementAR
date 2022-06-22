//
//  ItemStoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI

struct ItemStoreView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    Image("fireTest")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Bom dia").foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Pacote de 50 cartamnfjdbasjfbjdfajkbfas!")
                            .foregroundColor(.black)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                        NavigationLink(destination: PDFUIView(name: "freeCards")) {
                            Text("Comprar").padding(8).foregroundColor(.white)
                        }
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }.frame(alignment: .leading)
            }.padding()

        }
        .frame(height: 150)
        .cornerRadius(10)
        .padding()
        .navigationTitle("Store")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ItemStoreView()
    }
}
