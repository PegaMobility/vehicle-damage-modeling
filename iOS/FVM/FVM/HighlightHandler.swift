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

import SceneKit

internal class HighlightHandler {
    private var nodeMaterialMap = Dictionary<String, (node: SCNNode, material: Any)>()
    private let animationDuration: CFTimeInterval = 0.5
    
    internal func setHighlightOn(node: SCNNode) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = animationDuration
        let nodeName = node.name!
        guard let material = node.geometry?.firstMaterial?.diffuse.contents else {
            print("Can't highlight part without material")
            return
        }
        nodeMaterialMap[nodeName] = (node: node, material: material)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        SCNTransaction.commit()
    }
    
    internal func setHighlightOff(nodeName: String) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = animationDuration
        let tuple = nodeMaterialMap[nodeName]!
        tuple.node.geometry?.firstMaterial?.diffuse.contents = tuple.material
        nodeMaterialMap.removeValue(forKey: nodeName)
        SCNTransaction.commit()
    }
    
    internal func setAllHighlightsOff() {
        for tuple in nodeMaterialMap.values {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = animationDuration
            tuple.node.geometry?.firstMaterial?.diffuse.contents = tuple.material
            SCNTransaction.commit()
        }
        nodeMaterialMap.removeAll()
    }
    
    internal func isHighlighted(nodeName: String) -> Bool {
        return nodeMaterialMap.keys.contains(nodeName)
    }
}
