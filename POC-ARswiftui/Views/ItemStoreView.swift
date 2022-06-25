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
    private var isBought: Bool
    private var isAvailable: Bool
    
    init(name: String, imageName: String, price: Float, description: String, pdfName: String, isBought: Bool, isAvailable: Bool) {
        self.name = name
        self.imageName = imageName
        self.price = price
        self.description = description
        self.pdfName = pdfName
        self.isBought = isBought
        self.isAvailable = isAvailable
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
                            .font(.system(.title2, design: .rounded) .weight(.semibold))
                        Text(description)
                            .foregroundColor(.black)
                            .font(.system(.caption, design: .rounded))
                            .fixedSize(horizontal: false, vertical: true)
                        HStack {
                            Spacer()
                            if isAvailable {
                                if isBought {
                                    NavigationLink(destination: PDFUIView(name: pdfName)) {
                                        Text("Abrir")
                                            .padding(8)
                                            .foregroundColor(.white)
                                            .font(.system(.body, design: .rounded))
                                    }
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                } else {
                                    NavigationLink(destination: PDFUIView(name: pdfName)) {
                                        Text("R$ \(price, specifier: "%.2f")")
                                            .padding(8)
                                            .foregroundColor(.white)
                                            .font(.system(.body, design: .rounded))
                                    }
                                    .background(Color.green)
                                    .cornerRadius(10)
                                }
                            } else {
                                Text("Em breve")
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .font(.system(.body, design: .rounded))
                                    .background(Color.gray)
                                    .cornerRadius(10)
                            }
                            
                        }
                        
                    }
                }.frame(alignment: .leading)
            }.padding(8)

        }
        .frame(height: 150)
        .cornerRadius(10)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.trailing, 8)
        .padding(.leading, 8)
        .padding(.top, 8)
    }
}

struct ItemStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ItemStoreView(name: "Free", imageName: "fire", price: 10, description: "Muito bacana", pdfName: "freeCards", isBought: true, isAvailable: true)
    }
}
