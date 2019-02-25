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


import XCTest
import SceneKit
@testable import FVM

public class MaterialProcessorTests: XCTestCase {
    
    func test_highlightNamelessNode_nothingHighlighted() {
        let invalidNode = setupNode(name: nil, color: UIColor.white)
        let processor = MaterialProcessor()
        
        processor.highlightNewMaterial(forNode: invalidNode)
        
        XCTAssertEqual(UIColor.white, invalidNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
    }
    
    func test_highlightNodeWithoutMaterial_nothingHighlighted() {
        let invalidNode = setupNode(name: "Invalid", color: UIColor.white)
        invalidNode.geometry?.firstMaterial = nil
        let processor = MaterialProcessor()
        
        processor.highlightNewMaterial(forNode: invalidNode)
        
        XCTAssertFalse(processor.hasKeyFor("Invalid"))
    }
    
    func test_highlightValidNode_materialChangedAndAddedToDictionary() {
        let validNode = setupNode(name: "Valid", color: UIColor.white)
        let processor = MaterialProcessor()
        
        processor.highlightNewMaterial(forNode: validNode)
        
        XCTAssertEqual(UIColor.red, validNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
        XCTAssertTrue(processor.hasKeyFor("Valid"))
    }
    
    func test_restoreMaterial_nodesOriginalMaterialRestoredAndNodeDeletedFromDictionary () {
        let validNode = setupNode(name: "Valid", color: UIColor.white)
        let processor = MaterialProcessor()
        processor.highlightNewMaterial(forNode: validNode)
        
        processor.restoreMaterial(for: "Valid")
        
        XCTAssertEqual(UIColor.white, validNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
        XCTAssertFalse(processor.hasKeyFor("Valid"))
    }
    
    func test_restoreMaterialOnNotExistingNode_nothingChanged() {
        let validNode = setupNode(name: "Valid", color: UIColor.white)
        let processor = MaterialProcessor()
        processor.highlightNewMaterial(forNode: validNode)
        
        processor.restoreMaterial(for: "Invalid")
        
        XCTAssertEqual(UIColor.red, validNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
        XCTAssertTrue(processor.hasKeyFor("Valid"))
    }
    
    func test_restoreAll_restoresAllNodesMaterialsAndClearsDictionary() {
        let firstValidNode = setupNode(name: "Valid1", color: UIColor.white)
        let secondValidNode = setupNode(name: "Valid2", color: UIColor.black)
        let thirdValidNode = setupNode(name: "Valid3", color: UIColor.yellow)
        let processor = MaterialProcessor()
        processor.highlightNewMaterial(forNode: firstValidNode)
        processor.highlightNewMaterial(forNode: secondValidNode)
        processor.highlightNewMaterial(forNode: thirdValidNode)
        
        processor.restoreAll()
        
        XCTAssertEqual(UIColor.white, firstValidNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
        XCTAssertEqual(UIColor.black, secondValidNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
        XCTAssertEqual(UIColor.yellow, thirdValidNode.geometry?.firstMaterial?.diffuse.contents as! UIColor)
        XCTAssertFalse(processor.hasKeyFor("Valid1"))
        XCTAssertFalse(processor.hasKeyFor("Valid2"))
        XCTAssertFalse(processor.hasKeyFor("Valid3"))
    }
    
    func test_hasKeyFor_returnsTrueWhenNodeExistsInDictionary() {
        let node = setupNode(name: "Valid", color: UIColor.white)
        let processor = MaterialProcessor()
        processor.highlightNewMaterial(forNode: node)
        
        let actual = processor.hasKeyFor("Valid")
        
        XCTAssertTrue(actual)
    }
    
    func test_hasKeyFor_returnsFalseWhenNodeDoesNotExistInDictionary() {
        let processor = MaterialProcessor()
        
        let actual = processor.hasKeyFor("AnyKey")
        
        XCTAssertFalse(actual)
    }
    
    private func setupNode(name: String?, color: UIColor) -> SCNNode {
        let node = SCNNode()
        node.geometry = SCNBox()
        node.name = name
        let material = SCNMaterial()
        material.diffuse.contents = color
        node.geometry?.firstMaterial = material
        return node
    }
}
