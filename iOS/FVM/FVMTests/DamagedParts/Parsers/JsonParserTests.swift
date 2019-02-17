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

    private var sut = JsonParser<SelectionRoot>()
    
    override func setUp() {
        
      sut = JsonParser<SelectionRoot>()
        
    }

    func testIfReturnsNillWhenJsonIsInvalid() {
        //Arrange
        sut = JsonParser<SelectionRoot>()
        let simpleJson = "{invalid{"
        
        //Act
        let result = sut.parse(jsonData: simpleJson)
        
        //Assert
        XCTAssertNil(result)
    }
    
    func testIfContainsExaclyOneSelectedPart(){
        //Arrange
        sut = JsonParser<SelectionRoot>()
        let oneElementJson = """
{
   "selection":[
      {
         "id":"simpleId"
      }
   ]
}

"""

        //Act
        let result = sut.parse(jsonData: oneElementJson)
        
        //Assert
        XCTAssert(result!.selection.count == 1)
        
    }
    
    func testIfPartHasCorrectId(){
        //Arrange
        sut = JsonParser<SelectionRoot>()
        
        let oneElementJson = """
{
   "selection":[
      {
         "id":"simpleId"
      }
   ]
}

"""
        
        //Act
        let result = sut.parse(jsonData: oneElementJson)
        
        //Assert
        XCTAssert(result!.selection[0].id == "simpleId")
        
    }

}
