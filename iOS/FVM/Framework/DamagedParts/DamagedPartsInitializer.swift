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


internal class DamagedPartsInitializer : DamagedPartsInitializerProtocol{
    
    private var nodeHelper: NodeHelperProtocol
    private var carModel: SCNNode
    private var damagePartsService: DamagedPartsServiceProtocol
    private var initialConfiguration: String
    
    init(nodeHelper: NodeHelperProtocol, damagePartsService: DamagedPartsServiceProtocol, carModel: SCNNode, initialConfiguration: String) {
        self.nodeHelper = nodeHelper
        self.carModel = carModel
        self.damagePartsService = damagePartsService
        self.initialConfiguration = initialConfiguration
    }
    
    func Initialize(damagedPartsNamesToHightlight: [String]) {
        
        let initialDamagedParts = damagePartsService.createAndGetCollectionOfDamagedParts(json: initialConfiguration)
        
        let nodesToHighlight = nodeHelper.getIdsOfSelection(selections: initialDamagedParts)
        
        nodeHelper.updateDamagedPartsOnUI(damagedPartsNames: nodesToHighlight, carModel: carModel)
    }
}
    

