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
    private let materialProcessor = MaterialProcessor()
    private let animationDuration: CFTimeInterval = 0.5
    
    internal func setHighlightOn(node: SCNNode) {
        runAnimatedAction {
            materialProcessor.highlightNewMaterial(forNode: node)
        }
    }
    
    internal func setHighlightOff(nodeName: String) {
        runAnimatedAction {
            materialProcessor.restoreMaterial(for: nodeName)
        }
    }
    
    internal func setAllHighlightsOff() {
        runAnimatedAction {
            materialProcessor.restoreAll()
        }
    }
    
    internal func isHighlighted(nodeName: String) -> Bool {
        return materialProcessor.hasKeyFor(nodeName)
    }
    
    private func runAnimatedAction(action: () -> Void) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = animationDuration
        action()
        SCNTransaction.commit()
    }
}
