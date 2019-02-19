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

    
    private var parserMock : ParserMock<SelectionRoot>?
    private var sut: DemagedPartsServiceImpl?
    
    override func setUp() {
        parserMock = ParserMock()
        sut = DemagedPartsServiceImpl(parser: parserMock!)
    }

    func testIfSelectionArrayHasOneElementWhenOneElementJsonIsPassed() {
        //Arrange
        let simpleJson = simpleJsonWithOnePart.0
        
        //Act
        let result = sut?.createAndGetCollectionOfDamagedParts(json: simpleJson)
        
        //Assert
        XCTAssert(result?.count == 1)
    }
    
    func testIfSelectionArrayRetursProperPart(){
        //Arrange
        let simpleJson = simpleJsonWithOnePart.0
        let expected = simpleJsonWithOnePart.1[0].id
        
        //Act
        let actual = sut?.createAndGetCollectionOfDamagedParts(json: simpleJson)[0].id
        
        //Assert
        XCTAssertEqual(actual, expected)
    }
    
    func testIfReturnsEmptyArrayWhenNothingWasInvonked(){
        //Act
        let actual = sut?.getCollectionOfDamagedParts()
        
        //Assert
        XCTAssert(actual?.count == 0)
    }
    
    func testIfParserWasCalledOnce(){
        //Act
        sut?.createCollectionOfDamagedParts(json: "")
        
        //Assert
        XCTAssertEqual(parserMock?.parseCalls, 1)
    }

}
