import ARKit
import SwiftUI
import RealityKit

//Displays as a SwiftUI View
struct ContentView : View {
    @State var openConquistas = false
    @State var text = "Lava"
    @State var background = Color.red
    @StateObject var storeManager = StoreManager()
    let productIDs = ["lucaHummel.elementar.Store.IAP.ElementarDeck"]

    
    var body: some View {
        NavigationView {
            ZStack {
                ARViewContainer().edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack {
                        NavigationLink(destination: StoreView(storeManager: storeManager)
                            .onAppear(perform: {
                                storeManager.payment.default().add(storeManager)
                                storeManager.getProducts(productIDs: productIDs)
                            })) {
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
                VStack {
                    Spacer()
                    textView(text: $text, background: $background)
                }
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


