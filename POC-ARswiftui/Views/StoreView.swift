//
//  StoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Text(LocalizedStringKey("⚠️ You need a printer ⚠️"))
                    .foregroundColor(.white)
                    .padding()
                    .background(.yellow.opacity(0.8))
                    .cornerRadius(15)
                    .padding(.top, 20)
                    .font(.system(.body, design: .rounded))

                ForEach(storeManager.myProducts, id: \.self) { product in
                    ItemStoreView(product: product, storeManager: storeManager)
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Store"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        storeManager.restoreProducts()
                    }) {
                        Text(LocalizedStringKey("Restore Purchases"))
                            .foregroundColor(.green)
                    }
                }
            })
        .background(Color.blackElementar)
    }

}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(storeManager: StoreManager())
    }
}
