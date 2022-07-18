//
//  OnBoardingView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 27/06/22.
//

import SwiftUI

struct OnBoardingView: View {
    let images = ["printer.fill", "camera.on.rectangle.fill", "leaf.fill"]
    let texts = [LocalizedStringKey("1. Print the cards"), LocalizedStringKey("2. Aim the camera at two cards"), LocalizedStringKey("3. Discover new elements")]
    let colors = [Color.redElementar, Color.blueElementar, Color.greenElementar]
    
    init() {
        scene = try? Experience.loadElements()
        if scene == nil {
            fatalError("Can't load the 3D models")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 24) {
                VStack {
                    Text(LocalizedStringKey("Welcome to"))
                        .foregroundColor(.white)
                        .font(.system(.title3, design: .rounded))
                    Text("Elementar")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                }
                
                Spacer()
                VStack(spacing: 32) {
                    ForEach(0...images.count-1, id: \.self) { id in
                        HStack {
                            ButtonView(systemIcon: images[id], size: 100, color: colors[id])
                            Text(texts[id])
                                .padding()
                                .foregroundColor(.white)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(.body, design: .rounded))
                            Spacer()
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                    Text(LocalizedStringKey("Continue"))
                        .padding(16)
                        .padding(.leading, 32)
                        .padding(.trailing, 32)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                Spacer()
            }.padding()
            .background(Color.blackElementar)
        }.preferredColorScheme(.dark)
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
