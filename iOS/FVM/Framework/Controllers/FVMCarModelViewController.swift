// Copyright 2019 Flying Vehicle Monster team
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import SceneKit

internal class FVMCarModelViewController : SCNView {
    internal var damagedPartsService: DamagedPartsServiceProtocol!
    internal var nodeHelper: NodeHelperProtocol?
    internal var scnScene: SCNScene!
    internal var scnCamera: SCNNode!
    internal var scnCameraOrbit: SCNNode!
    internal let highlightHandler = HighlightHandler()
    private let CAR_MODEL_NAME = "carModel"
    
    public func onStartup(configuration: String) {
        self.autoenablesDefaultLighting = true
        nodeHelper = NodeHelper(highlightHandler: highlightHandler)
        
        setupGestures()
        setupScene()
        setupCamera()
        setupLights()
        setupInitialSelection(configuration: configuration)
    }
    
    public func onAccept() -> String {
        return damagedPartsService.getSerializedParts()
    }
    
    public func onCancel() -> String {
        return damagedPartsService.originalConfiguration
    }
    
    public func getInitialSelectionRoot() -> SelectionRoot? {
        return damagedPartsService.originalSelectionRoot
    }
    
    private func setupInitialSelection(configuration: String) {
        let carModelNode = scnScene.rootNode.childNode(withName: CAR_MODEL_NAME, recursively: false)
        let validNodesNames = nodeHelper?.createValidNamesArray(carModel: carModelNode!)
        damagedPartsService = DamagePartsServiceFactory.create(validPartsNames: validNodesNames!)
        let damagedPartsInitializer = DamagedPartsInitializer(nodeHelper: nodeHelper!, damagePartsService: damagedPartsService, carModel: carModelNode!, initialConfiguration: configuration)
        damagedPartsInitializer.initialize(damagedPartsNamesToHightlight: validNodesNames!)
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        configurePanGestureRecognizer(&panGesture)
        self.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(pinchGesture)
        self.addGestureRecognizer(panGesture)
    }
        
    private func setupScene() {
        scnScene = SCNScene(named: "art.scnassets/model.scn")
        self.scene = scnScene
    }
    
    private func setupCamera() {
        scnCamera = scnScene.rootNode.childNode(withName: "camera", recursively: false)
        
        scnCameraOrbit = SCNNode()
        scnCameraOrbit.eulerAngles.x = 0.0
        scnCameraOrbit.eulerAngles.y = -1.1
        
        if #available(iOS 11.0, *) {
            scnCamera.camera!.fieldOfView = ZoomConstraint.maxFOV
        } else {
            scnCamera.camera!.yFov = Double(ZoomConstraint.maxFOV)
        }
        
        scnCameraOrbit.addChildNode(scnCamera)
        scnScene.rootNode.addChildNode(scnCameraOrbit)
    }
    
    private func setupLights() {
        let topLight = SCNNode()
        topLight.light = SCNLight()
        topLight.light?.type = .directional
        topLight.position = SCNVector3(x: 0, y: 50, z: 0)
        topLight.eulerAngles = SCNVector3Make(Float(-Double.pi / 2), 0, 0)
        scnScene.rootNode.addChildNode(topLight)
        
        let bottomLight = SCNNode()
        bottomLight.light = SCNLight()
        bottomLight.light?.type = .directional
        bottomLight.light?.intensity = 750
        bottomLight.position = SCNVector3(x: 0, y: -50, z: 0)
        bottomLight.eulerAngles = SCNVector3Make(Float(-Double.pi / 2), 0, 0)
        scnScene.rootNode.addChildNode(bottomLight)
    }
}
