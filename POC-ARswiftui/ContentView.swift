import ARKit
import SwiftUI
import RealityKit

//Displays as a SwiftUI View
struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    var arView = ARView(frame: .zero)

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate{
        var parent: ARViewContainer
        var objetos = [Entity]()
        var imageAnchors = [ARAnchor]()
        
        init(parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if !imageAnchors.contains(anchor) {
                    imageAnchors.append(anchor)
                }
                guard let imageAnchor = anchor as? ARImageAnchor else { return }
                
                // veririficar se tem nome a ancora e se é o nome que queremos
                if let imageName = imageAnchor.name {
                    var cartaObjeto = ""
                    let entity = AnchorEntity(anchor: imageAnchor)
                    
                    if imageAnchors.count == 2 {
                        if (imageAnchors[0].name == "tia" && imageAnchors[1].name == "oficina1") || ((imageAnchors[0].name == "oficina1" && imageAnchors[1].name == "tia")) {
                            cartaObjeto = "mud"
                        }
                        
                        if let scene = try? Experience.loadElements() {
                
                            if let obj = scene.findEntity(named: cartaObjeto) {
                                obj.position.x = 0
                                obj.position.y = 0.05
                                obj.position.z = 0

                                //obj.components.set(pointLight)
                                objetos.append(obj)
                                entity.addChild(obj)
                                parent.arView.scene.addAnchor(entity)
                            }
                        }
                    } else {
                        if imageName == "oficina1" {
                            cartaObjeto = "water"
                        } else {
                            cartaObjeto = "dirt"
                        }
                        
                        if let scene = try? Experience.loadElements() {
                
                            if let obj = scene.findEntity(named: cartaObjeto) {
                                obj.position.x = 0
                                obj.position.y = 0.05
                                obj.position.z = 0

                                //obj.components.set(pointLight)
                                objetos.append(obj)
                                entity.addChild(obj)
                                parent.arView.scene.addAnchor(entity)
                            }
                        }
                    }
                }
            }
        }
        
        func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
            print("oi")
        }
        
        //Checks for tracking status
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for objeto in objetos {
                objeto.transform.rotation *= simd_quatf(angle: 0.005, axis: SIMD3<Float>(0,1,0))
            }
        }
    }
    
    func makeUIView(context: Context) -> ARView {
        guard let referenceImages = ARReferenceImage.referenceImages(
                    inGroupNamed: "AR Resources", bundle: nil) else {
                    fatalError("Missing expected asset catalog resources.")
                }
        
        //Assigns coordinator to delegate the AR View
        arView.session.delegate = context.coordinator
        
        let configuration = ARImageTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 2
        
        //Enables People Occulusion on supported iOS Devices
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            configuration.frameSemantics.insert(.personSegmentationWithDepth)
        } else {
            print("People Segmentation not enabled.")
        }

        arView.session.run(configuration)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
