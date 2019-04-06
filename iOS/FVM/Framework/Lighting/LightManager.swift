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

internal class LightManager {
    private var scnScene: SCNScene!
    
    init(scene: SCNScene) {
        scnScene = scene
    }
    
    internal func setup(){
        let topLight = SCNNode()
        let bottomLight = SCNNode()
        let centralLight = SCNNode()
        let topLightIntensity = CGFloat(500)
        let bottomLightIntensity = CGFloat(750)
        let centralLightIntensity = CGFloat(1000)
        let topLightVector = SCNVector3(x: 0, y: 50, z: 0)
        let bottomLightVector = SCNVector3(x: 0, y: -50, z: 0)
        let centralLightVector = SCNVector3(x: 0, y: 0, z: 0)
        
        set(type: SCNLight.LightType.directional, intensity: topLightIntensity, position: topLightVector, target: topLight)
        set(type: SCNLight.LightType.directional, intensity: bottomLightIntensity, position: bottomLightVector, target: bottomLight)
        set(type: SCNLight.LightType.ambient, intensity: centralLightIntensity, position: centralLightVector, target: centralLight)
    }
    
    private func set(type: SCNLight.LightType, intensity: CGFloat, position: SCNVector3, target: SCNNode){
        target.light?.intensity = intensity
        target.light = SCNLight()
        target.light?.type = type
        target.position = position
        target.eulerAngles = SCNVector3Make(Float(-Double.pi / 2), 0, 0)
        scnScene.rootNode.addChildNode(target)
    }
}
