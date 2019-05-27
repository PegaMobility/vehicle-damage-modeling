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

extension FVMCarModelViewController {
    @objc
    internal func handleTapGesture(_ gestureRecognizer: UIGestureRecognizer) {
        let hitPoint = gestureRecognizer.location(in: self)
        let hitResults = self.hitTest(hitPoint)
        if hitResults.count > 0 {
            let result = hitResults.first!
            guard let nodeName = result.node.name else {
                Log.warning("Can't highlight part without name")
                return
            }
            hideRotationPrompt()
            if (highlightHandler.isHighlighted(nodeName: nodeName)) {
                setHighlightOff(nodeName: nodeName)
            } else {
                setHighlightOn(node: result.node)
            }
            notifyFinishButton()
        }
    }
    
    fileprivate func setHighlightOn(node: SCNNode) {
        damagedPartsService.addPart(part: Selection(newName: node.name!))
        highlightHandler.setHighlightOn(node: node)
    }
    
    fileprivate func setHighlightOff(nodeName: String) {
        damagedPartsService.removePart(partId: nodeName)
        highlightHandler.setHighlightOff(nodeName: nodeName)
    }
    
    fileprivate func notifyFinishButton() {
        let currentSelection = damagedPartsService.getCollectionOfDamagedParts().sorted(by: { $0.id < $1.id })
        let originalSelection = damagedPartsService.originalSelectionRoot!.selection.sorted(by: {$0.id < $1.id })
        if currentSelection == originalSelection {
            NotificationCenter.default.post(name: .disableAcceptButton, object: FVMDamagedCarViewController.self)
        } else {
            NotificationCenter.default.post(name: .enableAcceptButton, object: FVMDamagedCarViewController.self)
        }
    }
}
