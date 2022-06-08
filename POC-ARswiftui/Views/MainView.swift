//
//  MainView.swift
//  POC-ARswiftui
//
//  Created by Caroline Taus on 08/06/22.
//

import SwiftUI

struct MainView: View {
    @State var openConquistas = false
    
    var body: some View {
        ZStack {
            HStack{
                Spacer()
                VStack {
                    
                    Button {
                        openConquistas.toggle()
                    } label: {
                        ButtonConquistasView()
                    }
                    Spacer()
                }.padding()
            }
            if openConquistas {
                CollectionGridView()
                    .frame(width: 320, height: 500, alignment: .center)
                    .cornerRadius(20)
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
