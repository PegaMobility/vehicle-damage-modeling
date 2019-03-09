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
import XCTest
@testable import FVM

class NodeHelperTests: XCTestCase {
    
    private let ROOT_NODE_NAME = "carModel"
    private var hightlightHandlerMock: HightlightHandlerMock?
    private var sut: NodeHelper?
    
    override func setUp() {
        hightlightHandlerMock = HightlightHandlerMock()
        sut = NodeHelper(highlightHandler: hightlightHandlerMock!)
    }
    
    func testIfResultContainsProperNumberOfIds(){
        // Arrange
        let selections = [Selection(newName: "id"), Selection(newName: "id2")]
        let expected = selections.count;
        
        // Act
        let actual = sut?.getIdsOfSelection(selections: selections).count
        
        // Assert
        XCTAssertEqual(actual, expected)
    }
    
    func testIfResultContainsProperNumberOfNames(){
        // Arrange
        let nodeOne = SCNNode()
        nodeOne.name = "name"
        let nodes = [nodeOne]
        let expected = nodes.count;
        
        // Act
        let actual = sut?.getNodesNames(nodes: nodes).count
        
        // Assert
        XCTAssertEqual(actual, expected)
    }
    
    func testIfRetursChildsNodesNames(){
        // Arrange
        let childNames = ["roof", "hood"]
        let root = setUpRootNode(childNodesNames: childNames)
        
        // Act
        let actual = sut?.createValidNamesArray(carModel: root)
        
        // Assert
        XCTAssertEqual(childNames, actual)
    }
    
    fileprivate func setUpRootNode(childNodesNames: [String]) -> SCNNode{
        let root = SCNNode()
        root.name = ROOT_NODE_NAME
        
        for name in childNodesNames{
            let newChild = SCNNode()
            newChild.name = name
            root.addChildNode(newChild)
        }
        return root
    }
}
