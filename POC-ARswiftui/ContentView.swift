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
        var mixResult = ""
        var mixing = false
        var entidadesDict:[String:AnchorEntity] = [String: AnchorEntity]()
        var anchorMixName: String = ""
        var imageNames = ["water", "air", "fire", "dirt"]

    
        
        init(parent: ARViewContainer) {
            self.parent = parent
            parent.arView.environment.lighting.intensityExponent = 1
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let imageAnchor = anchor as? ARImageAnchor else { return }
                
                // veririficar se tem nome a ancora e se é o nome que queremos
                if let imageName = imageAnchor.name {
                    var cartaObjeto = ""
                    let entity = AnchorEntity(anchor: imageAnchor)
                                 
                    for name in imageNames {
                        if imageName == name {
                            cartaObjeto = name
                            entity.name = name
                        }
                    }
                    
                    entidadesDict[cartaObjeto] = entity
                    
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
        
        //Checks for tracking status
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            if anchors.count == 2 {
                if mixing == false {
                    mixing = true
                    let positionFirst = anchors[0].transform.columns.3
                    let positionSecond = anchors[1].transform.columns.3
                    
                    let positionMixX: Float = positionSecond.x - positionFirst.x
                    let positionMixZ: Float = positionSecond.z - positionFirst.z
                
                    if (anchors[0].name == "water" && anchors[1].name == "dirt") || ((anchors[0].name == "dirt" && anchors[1].name == "water")) {
                        mixResult = "mud"
                    }
                    
                    
                    mixResult = (anchors[0].name ?? "water") + (anchors[1].name ?? "dirt")
                                
                    if let scene = try? Experience.loadElements() {
                        if let obj = scene.findEntity(named: mixResult) {
                            //obj.components.set(pointLight)
                            obj.position.y = 0.1
                            obj.position.x = positionMixX/2 // positivo para direita
                            obj.position.z = positionMixZ/2 // positivo pra baixo
                            objetos.append(obj)
                            if let nome = anchors[0].name, let entidadeEle = entidadesDict[nome] {
                                entidadeEle.addChild(obj)
                                anchorMixName = nome
                            }
                        } else {
                            mixResult =  (anchors[1].name ?? "dirt") + (anchors[0].name ?? "water")
                            if let obj = scene.findEntity(named: mixResult) {
                                //obj.components.set(pointLight)
                                obj.position.y = 0.1
                                obj.position.x = positionMixX/2 // positivo para direita
                                obj.position.z = positionMixZ/2 // positivo pra baixo
                                objetos.append(obj)
                                if let nome = anchors[0].name, let entidadeEle = entidadesDict[nome] {
                                    entidadeEle.addChild(obj)
                                    anchorMixName = nome
                                }
                            }
                        }
                    }
                }
            } else {
                mixing = false
                
                if let entidadeEle = entidadesDict[anchorMixName], let removeMix = entidadeEle.findEntity(named: mixResult) {
                    entidadeEle.removeChild(removeMix)
                }
            }
            
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
