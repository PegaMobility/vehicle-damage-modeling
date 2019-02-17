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

class DamagePartsServiceImplTests: XCTestCase {

    
    private var parserMock : ParserMock?
    private var sut: DemagedPartsServiceImpl?
    
    override func setUp() {
        parserMock = ParserMock()
        sut = DemagedPartsServiceImpl(parser: parserMock!)
    }

    func testIfSelectionArrayHasOneElementWhenOneElementJsonIsPassed() {
        //Arrange
        let simpleJson = """
        {
            "selection":[
                {
                    "id":"simpleId"
                }
            ]
        }

        """
        
        //Act
        let result = sut?.CreateAndGetCollectionOfDamagedParts(json: simpleJson)
        //Assert
        XCTAssert(result?.count == 1)
        
    }
    
    func testIfCallsParserOnce() {
        //Arrange
        parserMock = ParserMock()
        let simpleJson = """
        {
            "selection":[
                {
                    "id":"simpleId"
                }
            ]
        }

        """
        
        //Act
        sut?.CreateAndGetCollectionOfDamagedParts(json: simpleJson)
        
        //Assert
        var packed =  self.parserMock as! ParserMock
        
        XCTAssert(packed.simpleIdCalls == 1)
    }
    
    

}
