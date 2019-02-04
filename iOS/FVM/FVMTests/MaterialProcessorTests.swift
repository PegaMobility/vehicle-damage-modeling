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
    
    func test() {
        let processor = MaterialProcessor()
        let node = SCNNode()
        node.geometry = SCNBox()
        node.name = "Name"
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        node.geometry?.firstMaterial = material
        
        processor.highlightNewMaterial(forNode: node)
        XCTAssertTrue(processor.hasKeyFor(node.name!))
        XCTAssertEqual(node.geometry?.firstMaterial?.diffuse.contents as! UIColor, UIColor.red)
        
        processor.restoreMaterial(for: node.name!)
        XCTAssertFalse(processor.hasKeyFor(node.name!))
        XCTAssertEqual(node.geometry?.firstMaterial?.diffuse.contents as! UIColor, UIColor.yellow)
    }
    
    
}
