//
//  ItemStoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI

struct ItemStoreView: View {
    private var name: String
    private var imageName: String
    private var price: Float
    private var description: String
    private var pdfName: String
    
    init(name: String, imageName: String, price: Float, description: String, pdfName: String) {
        self.name = name
        self.imageName = imageName
        self.price = price
        self.description = description
        self.pdfName = pdfName
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 130)
                        .clipped()
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 16) {
                        Text(name).foregroundColor(.black)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(description)
                            .foregroundColor(.black)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                        HStack {
                            Spacer()
                            NavigationLink(destination: PDFUIView(name: pdfName)) {
                                Text("R$ \(price, specifier: "%.2f")").padding(8).foregroundColor(.white)
                            }
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                        
                    }
                }.frame(alignment: .leading)
            }.padding(8)

        }
        .frame(height: 150)
        .cornerRadius(10)
        .navigationTitle("Store")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.trailing, 8)
        .padding(.leading, 8)
        .padding(.top, 8)

    }
}

struct ItemStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ItemStoreView(name: "Free", imageName: "fire", price: 10, description: "Muito bacana", pdfName: "freeCards")
    }
}
