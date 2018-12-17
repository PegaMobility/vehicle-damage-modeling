//
//  FVMCarModelViewController.swift
//  FVM
//
//

import UIKit
import SceneKit

open class FVMCarModelViewController : SCNView {
    var scnScene: SCNScene!
    var scnCamera : SCNNode!
    var highlightedParts = [SCNNode]()
    
    public func viewDidLoad() {
        self.backgroundColor = UIColor.darkGray
        self.allowsCameraControl = true
        self.autoenablesDefaultLighting = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        self.addGestureRecognizer(tapGesture)
        setupScene()
        drawSphereGrid(xAmount: 5, yAmount: 5, radius: 0.5)
    }

    func setupScene() {
        scnScene = SCNScene()
        self.scene = scnScene
        
        scnCamera = SCNNode()
        scnCamera.camera = SCNCamera()
        scnCamera.position = SCNVector3(x: 0, y: 0, z: 10)
        scnCamera.camera?.zFar = 50
       // scnCamera.camera?.fieldOfView = 100    // iOS 11 and newer only
        scnScene.rootNode.addChildNode(scnCamera)
    }
    
    open func drawPyramid() {
        let scnPyramidNode = SCNNode()
        scnPyramidNode.geometry = SCNPyramid(width: 10, height: 15, length: 10)
        scnPyramidNode.geometry?.insertMaterial(SCNMaterial(), at: 1)
        scnPyramidNode.position = SCNVector3(x: 0, y: -6, z: -30)   // must be relative to the parent node
        scnPyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        scnScene.rootNode.addChildNode(scnPyramidNode)
    }
    
    open func drawSphereGrid(xAmount : Int, yAmount : Int, radius : CGFloat) {
        var y : Float = 0.0
        for rowNo in 0 ..< yAmount {
            var x : Float = 0.0
            for columnNo in 0 ..< xAmount {
                let sphere = SCNSphere(radius: radius)
                if ((rowNo + columnNo) % 2 == 0) {
                    sphere.firstMaterial?.diffuse.contents = UIColor.red
                } else {
                    sphere.firstMaterial?.diffuse.contents = UIColor.blue
                }
                let node = SCNNode(geometry: sphere)
                node.position = SCNVector3(x: x, y: y, z: 0)
                node.name = "(\(x), \(y))"
                
                scnScene.rootNode.addChildNode(node)
                x += 2 * Float(radius)
            }
            y += 2 * Float(radius)
        }
        positionCameraAccordingly(xAmount: xAmount, yAmount: yAmount, radius: radius)
    }
    
    @objc
    func handleTapGesture(_ gestureRecognizer: UIGestureRecognizer) {
        let p = gestureRecognizer.location(in: self)
        let hitResults = self.hitTest(p, options: [:])
        if hitResults.count > 0 {
            let result = hitResults.first!
            if highlightedParts.contains(result.node) {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                highlightedParts.remove(at: highlightedParts.firstIndex(of: result.node)!)
                result.node.scale = SCNVector3(x: 1, y: 1, z: 1)
                SCNTransaction.commit()
            } else {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                highlightedParts.append(result.node)
                result.node.scale = SCNVector3(x: 2, y: 2, z: 2)
                SCNTransaction.commit()
            }
        } else {
            setHighlightsOff()
        }
    }
    
    func setHighlightsOff() {
        for part in highlightedParts {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            part.scale = SCNVector3(x: 1, y: 1, z: 1)
            SCNTransaction.commit()
        }
        highlightedParts.removeAll()
    }
    
    func positionCameraAccordingly(xAmount : Int, yAmount : Int, radius : CGFloat) {
        let x : Float = Float(xAmount - 1) * Float(radius)
        let y : Float = Float(yAmount - 1) * Float(radius)
        scnCamera.position = SCNVector3(x: x, y: y, z: 10)
    }
}

