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

import Foundation
import SceneKit

internal class NodeHelper : NodeHelperProtocol {
    private var highlightHandler: HighlightHandler
    private var supportedNamesProvider: DamagedPartsNamesProviderProtocol
    
    init(highlightHandler: HighlightHandler, supportedNamesProvider: DamagedPartsNamesProviderProtocol) {
        self.highlightHandler = highlightHandler
        self.supportedNamesProvider = supportedNamesProvider
    }
    
    internal func updateDamagedPartsOnUI(damagedPartsNames: [String], carModel: SCNNode){
        for partName in damagedPartsNames{
            let nodeToHighlight = carModel.childNode(withName: partName, recursively: true)
            highlightHandler.setHighlightOn(node: nodeToHighlight!)
        }
    }
    
    internal func createValidNamesArray(carModel: SCNNode) -> [String]? {
        let childNodes = carModel.childNodes
        let validNodesNames = getNodesNames(nodes: childNodes)
        return validNodesNames
    }
    
    internal func getNodesNames(nodes: [SCNNode]) -> [String] {
        var validNames = [String]()
        let supportedNames = supportedNamesProvider.getValidNames()
        for node in nodes {
            if let nodeName = node.name {
                if supportedNames.contains(nodeName) {
                    validNames.append(nodeName)
                }
            }
        }
        return validNames
    }

    internal func getIdsOfSelection(selections: [Selection]?) -> [String] {
        return (selections?.map{ $0.id })!
    }
}
