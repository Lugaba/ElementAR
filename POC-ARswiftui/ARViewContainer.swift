//
//  ARViewContainer.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 08/06/22.
//

import ARKit
import SwiftUI
import RealityKit

var scene: Experience.Elements?

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
        var free = ["Water", "Air", "Fire", "Dirt"]
        var imageNames: [String] = ["Water", "Air", "Fire", "Dirt"]
        var dictMixs:[String:String] = ["AirDirt": "Dust", "AirWater": "Rain", "AirFire": "Energy", "DirtFire": "Lava", "DirtWater": "Mud", "FireWater": "Steam", "DustFire": "Gunpowder","AirLava": "Stone", "LavaWater": "Obsidian", "DirtEnergy": "Seed", "EnergyFire": "Sun", "AirStone": "Moon", "EnergyStone": "Crystal", "StoneWater": "Sand", "FireStone": "Metal", "RainSun": "Rainbow", "DirtSeed": "Grass", "CrystalWater": "Sapphire", "CrystalDirt": "Emerald", "MoonWater": "Earth", "CrystalFire": "Ruby", "SandWater": "Clay", "FireSand": "Glass", "MetalWater": "Mercury", "MetalStone": "Blade", "GrassWater": "Tree", "MetalSun": "Gold", "SandStone": "Sandstone", "GunpowderMetal": "Bomb", "ClayFire": "Brick", "ClayStone": "Cement", "GlassWater": "Ice", "GlassMetal": "Mirror", "BladeTree": "Wood", "FireTree": "Coal", "AirIce": "Snow", "FireWood": "Smoke", "BladeWood": "Paper", "CoalMetal": "Steel", "CoalWater": "Petroleum"]
        var isBought = UserDefaults.standard.bool(forKey: "lucaHummel.elementar.Store.IAP.ElementarDeck")
        var numberDiscovered: Int = UserDefaults.standard.integer(forKey: "numberDiscovered")
        
        
        init(parent: ARViewContainer) {
            self.parent = parent
            parent.arView.environment.lighting.intensityExponent = 2
            if scene == nil {
                do {
                    scene = try Experience.loadElements()
                } catch {
                    fatalError()
                }
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
                    if imageNames.contains(imageName){
                        if !UserDefaults.standard.bool(forKey: imageName) {
                            numberDiscovered += 1
                            UserDefaults.standard.set(numberDiscovered, forKey: "numberDiscovered")
                        }
                        UserDefaults.standard.set(true, forKey: imageName)
                        
                        if free.contains(imageName) {
                            cartaObjeto = imageName
                        } else {
                            if isBought {
                                cartaObjeto = imageName
                            } else {
                                cartaObjeto = "blocked"
                            }
                        }
                    } else {
                        if isBought {
                            cartaObjeto = "unknow"
                        } else {
                            cartaObjeto = "blocked"
                        }
                    }
                    print(imageName)
                    entidadesDict[imageName] = entity
                    if let  scene = scene {
                        if let obj = scene.findEntity(named: cartaObjeto) {
                            let objClone = obj.clone(recursive: true)
                            objClone.position.x = 0
                            objClone.position.y = 0.015
                            objClone.position.z = 0
                            
                            objetos.append(objClone)
                            entity.addChild(objClone)
                            parent.arView.scene.addAnchor(entity)
                        }
                    }
                }
            }
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let anchorName = entidadesDict[anchor.name!], let removeMix = anchorName.findEntity(named: "blocked") {
                    self.isBought = UserDefaults.standard.bool(forKey: "lucaHummel.elementar.Store.IAP.ElementarDeck")
                    if let scene = scene, let obj = scene.findEntity(named: "unknow"), isBought {
                        anchorName.removeChild(removeMix)
                        objetos.remove(at: objetos.firstIndex(of: removeMix)!)
                        let objClone = obj.clone(recursive: true)
                        objClone.position.x = 0
                        objClone.position.y = 0.015
                        objClone.position.z = 0
                        
                        objetos.append(objClone)
                        anchorName.addChild(objClone)
                    }
                }
            }
            
            if anchors.count == 2 {
                if mixing == false {
                    mixing = true
                    
                    var isDiscovered1: Bool = false
                    var isDiscovered2: Bool = false
                    var havePermission: Bool = true
                    
                    let positionFirst = anchors[0].transform.columns.3
                    let positionSecond = anchors[1].transform.columns.3
                    
                    let positionMixX: Float = positionSecond.x - positionFirst.x
                    let positionMixZ: Float = positionSecond.z - positionFirst.z
                    
                    if let nome1 = anchors[0].name, let nome2 = anchors[1].name, let letra1 = nome1.first, let letra2 = nome2.first {
                        isDiscovered1 = UserDefaults.standard.bool(forKey: "\(nome1)")
                        isDiscovered2 = UserDefaults.standard.bool(forKey: "\(nome2)")
                        
                        if !isBought && (!free.contains(nome1) || !free.contains(nome2)) {
                            havePermission = false
                        }
                        
                        if letra1 < letra2 {
                            mixResult = nome1 + nome2
                        } else {
                            mixResult = nome2 + nome1
                        }
                    }
                    if let scene = scene, isDiscovered1, isDiscovered2, havePermission {
                        if let nameDict = dictMixs[mixResult] {
                            if !UserDefaults.standard.bool(forKey: nameDict) {
                                numberDiscovered += 1
                                UserDefaults.standard.set(numberDiscovered, forKey: "numberDiscovered")
                            }
                            UserDefaults.standard.set(true, forKey: nameDict)
                            
                            mixResult = nameDict
                        }
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
                            
                            self.isBought = UserDefaults.standard.bool(forKey: "lucaHummel.elementar.Store.IAP.ElementarDeck")
                            if let anchorMix = entidadesDict[mixResult], let removeMix = anchorMix.findEntity(named: "unknow") ?? anchorMix.findEntity(named: "blocked"), isBought {
                                anchorMix.removeChild(removeMix)
                                objetos.remove(at: objetos.firstIndex(of: removeMix)!)
                                let objClone = obj.clone(recursive: true)
                                objClone.position.x = 0
                                objClone.position.y = 0.015
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
                    scene?.addChild(removeMix)
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
