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

internal class MaterialProcessor {
    private var materialStore = Dictionary<String, (node: SCNNode, material: Any?)>()
    private let SELECTION_COLOR = UIColor(red: 219/255, green: 114/255, blue: 114/255, alpha: 1.0)
    
    internal func highlightNewMaterial(forNode node: SCNNode) {
        guard let nodeName = node.name else {
            Log.warning("Can't highlight part without name")
            return
        }
        guard let material = node.geometry?.firstMaterial else {
            Log.warning("Can't highlight part without material")
            return
        }
        materialStore[nodeName] = (node, material.diffuse.contents)
        setHighlightedMaterial(for: nodeName)
    }
    
    internal func restoreMaterial(for nodeName: String) {
        guard let tuple = materialStore[nodeName] else {
            Log.warning("Node \(nodeName) not found")
            return
        }
        tuple.node.geometry?.firstMaterial?.diffuse.contents = tuple.material
        materialStore.removeValue(forKey: nodeName)
    }
    
    internal func restoreAll() {
        for name in materialStore.keys {
            restoreMaterial(for: name)
        }
    }
    
    internal func hasKeyFor(_ key: String) -> Bool {
        return materialStore.keys.contains(key)
    }
    
    private func setHighlightedMaterial(for nodeName: String) {
        guard let node = materialStore[nodeName]?.node else {
            Log.warning("Node \(nodeName) not found")
            return
        }
        node.geometry?.firstMaterial?.diffuse.contents = SELECTION_COLOR
    }
}
