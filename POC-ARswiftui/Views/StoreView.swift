//
//  StoreView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 20/06/22.
//

import SwiftUI

struct StoreView: View {
    let pacotes = [0, 1, 2, 3]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Text("Você precisa de uma impressora")
                ForEach((1...10).reversed(), id: \.self) { _ in
                    ItemStoreView().background(.purple)
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
