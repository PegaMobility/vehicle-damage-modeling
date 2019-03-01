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
@testable import FVM

class JsonParserTests: XCTestCase {
    private var sut : JsonParser<SelectionRoot>?
    
    override func setUp() {
      sut = JsonParser<SelectionRoot>()
    }

    func testIfReturnsNillWhenJsonIsInvalid() {
        //Arrange
        let invalidJson = "{invalid{"
        
        //Act
        let actual = sut!.parse(jsonData: invalidJson)
        
        //Assert
        XCTAssertNil(actual)
    }
    
    func testIfContainsExaclyOneSelectedPart(){
        //Arrange
        let oneElementJson = simpleJsonWithOnePart.0

        //Act
        let actual = sut!.parse(jsonData: oneElementJson)
        
        //Assert
        XCTAssert(actual?.selection.count == 1)
    }
    
    func testIfPartHasCorrectId(){
        //Arrange
        let oneElementJson = simpleJsonWithOnePart.0
        let expected = simpleJsonWithOnePart.1[0].id
        
        //Act
        let actual = sut!.parse(jsonData: oneElementJson)
        
        //Assert
        XCTAssertEqual(actual?.selection[0].id, expected)
    }
}
