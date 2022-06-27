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
                            ButtonView(systemIcon: "cart.fill", size: 60)
                        }
                        Button {
                            openConquistas.toggle()
                        } label: {
                            ButtonView(systemIcon: "menucard.fill", size: 60)
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
            CollectionGridView(openConquistas: $openConquistas)
                .frame(width: 350, height: 540, alignment: .center)
                .cornerRadius(20)
        } else {
            EmptyView()
        }
    }
}


