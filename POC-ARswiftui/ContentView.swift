import ARKit
import SwiftUI
import RealityKit

//Displays as a SwiftUI View
struct ContentView : View {
    @State var openConquistas = false
    @State var text = "Lava"
    @State var background = Color.red

    
    var body: some View {
        NavigationView {
            ZStack {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack {
                        NavigationLink(destination: InfoStoreView()) {
                            ButtonView(systemIcon: "cart.fill", size: 60, color: Color.blackElementar)
                            }
                        Button {
                            openConquistas.toggle()
                        } label: {
                            ButtonView(systemIcon: "menucard.fill", size: 60, color: Color.blackElementar)
                        }
                        Spacer()
                    }
                }.padding()
                InfoGridView(openConquistas: $openConquistas)
            }
        }.preferredColorScheme(.dark)
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

struct InfoStoreView: View {
    var storeManager = StoreManager()
    let productIDs = ["lucaHummel.elementar.Store.IAP.ElementarDeck", "lucaHummel.elementar.Store.IAP.FreeDeck"]

    
    init() {
        storeManager.payment.default().add(storeManager)
        storeManager.getProducts(productIDs: productIDs)
    }
    
    var body: some View {
        StoreView(storeManager: storeManager)
    }
}


