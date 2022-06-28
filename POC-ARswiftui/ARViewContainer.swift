//
//  ARViewContainer.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 08/06/22.
//

import ARKit
import SwiftUI
import RealityKit

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
        var imageNames: [String] = ["Água", "Ar", "Fogo", "Terra"]
        var dictMixs:[String:String] = ["ArTerra": "Poeira", "ArÁgua": "Chuva", "ArFogo": "Energia", "FogoTerra": "Lava", "TerraÁgua": "Lama", "FogoÁgua": "Vapor", "LavaÁgua": "Pedra"]
        var scene: Experience.Elements?
        var isBought = true
        
        
        init(parent: ARViewContainer) {
            self.parent = parent
            parent.arView.environment.lighting.intensityExponent = 2
            self.scene = try? Experience.loadElements()
            if self.scene == nil {
                fatalError("Can't load the 3D models")
            }
            if let imageNames = UserDefaults.standard.object(forKey: "imageNames") as? [String] {
                self.imageNames = imageNames
            }
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                guard let imageAnchor = anchor as? ARImageAnchor else { return }
                
                if let imageName = imageAnchor.name {
                    var cartaObjeto = ""
                    let entity = AnchorEntity(anchor: imageAnchor)
                    
                    entity.name = imageName
                    if imageNames.contains(imageName) {
                        UserDefaults.standard.set(true, forKey: imageName)
                        cartaObjeto = imageName
                    } else {
                        if isBought {
                            cartaObjeto = "unknow"
                        } else {
                            cartaObjeto = "blocked"
                        }
                    }
                    
                    entidadesDict[imageName] = entity
                    if let  scene = scene {
                        if let obj = scene.findEntity(named: cartaObjeto) {
                            let objClone = obj.clone(recursive: true)
                            objClone.position.x = 0
                            objClone.position.y = 0.025
                            objClone.position.z = 0
                            
                            objetos.append(objClone)
                            entity.addChild(objClone)
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
                    
                    if let nome1 = anchors[0].name, let nome2 = anchors[1].name, let letra1 = nome1.first, let letra2 = nome2.first {
                        if letra1 < letra2 {
                            mixResult = nome1 + nome2
                        } else {
                            mixResult = nome2 + nome1
                        }
                    }
                    
                    if let nameDict = dictMixs[mixResult] {
                        UserDefaults.standard.set(true, forKey: nameDict)
                        mixResult = nameDict
                    }
                    
                    print(mixResult)
                    if let scene = scene {
                        if let obj = scene.findEntity(named: mixResult) {
                            obj.position.y = 0.075
                            obj.position.x = positionMixX/2 // positivo para direita
                            obj.position.z = positionMixZ/2 // positivo pra baixo
                            UserDefaults.standard.set(true, forKey: mixResult)
                            if !objetos.contains(obj) {
                                objetos.append(obj)
                            }
                            if !imageNames.contains(mixResult) {
                                imageNames.append(mixResult)
                                UserDefaults.standard.set(imageNames, forKey: "imageNames")
                            }

                            if let anchorMix = entidadesDict[mixResult], let removeMix = anchorMix.findEntity(named: "unknow"), isBought {
                                anchorMix.removeChild(removeMix)
                                let objClone = obj.clone(recursive: true)
                                objClone.position.x = 0
                                objClone.position.y = 0.025
                                objClone.position.z = 0
                                
                                objetos.append(objClone)
                                anchorMix.addChild(objClone)
                            }
                            
                            if let nome = anchors[0].name, let entidadeEle = entidadesDict[nome] {
                                entidadeEle.addChild(obj)
                                anchorMixName = nome
                            }
                        }
                    }
                }
            } else {
                mixing = false
                
                if let entidadeEle = entidadesDict[anchorMixName], let removeMix = entidadeEle.findEntity(named: mixResult) {
                    // Descobri que addChild remove do parent atual e coloca no novo parent
                    self.scene?.addChild(removeMix)
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
