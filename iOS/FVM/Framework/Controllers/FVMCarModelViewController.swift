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
    internal var userPromptText: String? {
        return damagedPartsService.originalSelectionRoot?.mainScreenText
    }
    internal var damagedPartsService: DamagedPartsServiceProtocol!
    internal var modelScaleProvider: ModelScaleProviderProtocol!
    internal var nodeHelper: NodeHelperProtocol?
    internal var scnScene: SCNScene!
    internal var scnCamera: SCNNode!
    internal var scnCameraOrbit: SCNNode!
    internal let highlightHandler = HighlightHandler()
    private let CAR_MODEL_NAME = "carModel"
    
    public func onStartup(configuration: String) {
        setupScene()
        modelScaleProvider = ModelScaleProvider(scnScene.rootNode.childNode(withName: CAR_MODEL_NAME, recursively: false)!)
        
        setupGestures()
        setupCamera()
        setupLights()
        
        nodeHelper = NodeHelper(highlightHandler: highlightHandler)
        setupInitialSelection(configuration: configuration)
    }
    
    public func onAccept() -> String {
        return damagedPartsService.getSerializedParts()
    }
    
    public func onCancel() -> String {
        return damagedPartsService.originalConfiguration
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
        
        let modelScale = modelScaleProvider.getModelScale()
        scnCamera.camera!.zFar *= Double(modelScale)
        scnCamera.camera!.zNear *= Double(modelScale)
        scnCamera.position *= modelScale
        
        scnCameraOrbit = SCNNode()
        scnCameraOrbit.eulerAngles.x = -Float.pi * 0.0
        scnCameraOrbit.eulerAngles.y = -2 * Float.pi * 1.2
        
        scnCamera.camera!.setFOV(ZoomConstraint.maxFOV)
        
        scnCameraOrbit.addChildNode(scnCamera)
        scnScene.rootNode.addChildNode(scnCameraOrbit)
    }
    
    private func setupLights() {
        let lightManager = LightManager(scene: scnScene)
        lightManager.setup()
    }
}
