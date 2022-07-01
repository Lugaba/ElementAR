//
//  OnBoardingView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 27/06/22.
//

import SwiftUI

struct OnBoardingView: View {
    let images = ["printer.fill", "camera.on.rectangle.fill", "leaf.fill"]
    let texts = ["1. Imprima as cartas", "2. Aponte a câmera para as cartas", "3. Descubra novos elementos"]
    
    init() {
        scene = try? Experience.loadElements()
        if scene == nil {
            fatalError("Can't load the 3D models")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 24) {
                Text("Elementar")
                    .font(.system(.largeTitle, design: .rounded))
                Spacer()
                VStack(spacing: 32) {
                    ForEach(0...images.count-1, id: \.self) { id in
                        HStack {
                            ButtonView(systemIcon: images[id], size: 100)
                            Text(texts[id])
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(.body, design: .rounded))
                            Spacer()
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                    Text("Continuar")
                        .padding(16)
                        .padding(.leading, 32)
                        .padding(.trailing, 32)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                Spacer()
            }.padding()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
