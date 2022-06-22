import ARKit
import SwiftUI
import RealityKit

//Displays as a SwiftUI View
struct ContentView : View {
    @State var openConquistas = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack {
                        NavigationLink(destination: StoreView()) {
                            ButtonView(systemIcon: "cart.fill")
                        }
                        Button {
                            openConquistas.toggle()
                        } label: {
                            ButtonView(systemIcon: "menucard.fill")
                        }
                        Spacer()
                    }
                }.padding()
                
                InfoGridView(openConquistas: $openConquistas)
            }
        }
        
    }
}

struct InfoGridView: View {
    @Binding var openConquistas: Bool
    
    var body: some View {
        if openConquistas {
            CollectionGridView()
                .frame(width: 320, height: 540, alignment: .center)
                .cornerRadius(20)
        } else {
            EmptyView()
        }
    }
}


