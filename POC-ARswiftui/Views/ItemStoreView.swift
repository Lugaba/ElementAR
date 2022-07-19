//
//  ItemStoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI
import StoreKit


struct ItemStoreView: View {
    private var product: SKProduct
    private var name: String
    private var imageName: String
    private var price: NSDecimalNumber
    private var description: String
    private var pdfName: String
    private var isBought: Bool
    private var storeManager: StoreManager
    
    init(product: SKProduct , storeManager: StoreManager) {
        self.product = product
        self.name = product.localizedTitle
        self.imageName = product.productIdentifier
        self.price = product.price
        self.description = product.localizedDescription
        self.pdfName = product.productIdentifier
        self.isBought = UserDefaults.standard.bool(forKey: "\(product.productIdentifier)")
        self.storeManager = storeManager
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
                            if isBought {
                                NavigationLink(destination: PDFUIView(name: pdfName)) {
                                    Text("Open")
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .font(.system(.body, design: .rounded))
                                }
                                .background(Color.blue)
                                .cornerRadius(10)
                            } else {
                                Button(action: {
                                    storeManager.purchaseProduct(product: self.product)
                                }) {
                                    Text("R$ \(price)")
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .font(.system(.body, design: .rounded))
                                }
                                .background(Color.green)
                                .cornerRadius(10)
                            }
                            
                            
                        }
                        
                    }
                }.frame(alignment: .leading)
            }.padding(8)
            
        }
        .frame(height: 150)
        .cornerRadius(10)
        .padding(.trailing, 8)
        .padding(.leading, 8)
        .padding(.top, 8)
    }
}
