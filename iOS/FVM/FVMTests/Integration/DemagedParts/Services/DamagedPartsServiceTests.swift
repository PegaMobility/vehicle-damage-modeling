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

class DamagedPartsServiceTests: XCTestCase {
    private var parser: JsonParser<SelectionRoot>?
    private var validator: DamagedPartsValidator?
    private var partsNamesProvider: DamagedPartsNamesProvider?
    private var repository: DamagedPartsRepository?
    private var sut: DamagedPartsService?
    
    let validPartsNames = ["MirrorRight", "MirrorLeft", "Roof"]

    override func setUp() {
        
        partsNamesProvider = DamagedPartsNamesProvider(validPartsNames: validPartsNames)
        validator = DamagedPartsValidator(provider: partsNamesProvider!)
        repository = DamagedPartsRepository()
        parser = JsonParser<SelectionRoot>()

        sut = DamagedPartsService(parser: parser!, validator: validator!, repository: repository!)
    }
    
    func testIfCreatesSelectionArrayProperly(){
        // Arrange
        let jsonWithOnePart = """
        {
            "mainScreenText": "text",
            "selection":[
            {
                "id":"MirrorRight"
            }
            ]
        }
        """
        
        // Act
        let actual = sut?.createAndGetCollectionOfDamagedParts(json: jsonWithOnePart)
        
        // Assert
        
        assert(actual?.count == 1)
        assert(actual?[0].id == "MirrorRight")
    }
    
    func testIfRemovesInvalidParts(){
        // Arrange
        let jsonWithInvalidParts = """
        {
            "mainScreenText": "text",
            "selection":[
            {
                "id":"MirrorRight"
            },
            {
                "id":"invalidName"
            },
            {
                "id":"invalidName2"
            }

            ]
        }
        """
        
        
        // Act
        let actual = sut?.createAndGetCollectionOfDamagedParts(json: jsonWithInvalidParts)
        
        // Assert
        XCTAssert(actual?.count == 1)
        XCTAssert(actual?[0].id == "MirrorRight" )
    }
    
    func testIfReturnsEmptyArrayWhenJsonIsInvalid()  {
        // Arrange
        let invalidJson = "{}}{}invalidJson{{]}}{"
        
        // Act
        let actual = sut?.createAndGetCollectionOfDamagedParts(json: invalidJson)
        
        // Assert
        XCTAssertNotNil(actual)
        XCTAssert(actual?.count == 0)
    }
    
    func testIfAddsOnePartProperly(){
        // Arrange
        let part = Selection(newName: "MirrorRight")
        
        // Act
        sut?.addPart(part: part)
        var actual = sut?.getCollectionOfDamagedParts()
        
        // Assert
        XCTAssert(actual?.count == 1)
        XCTAssert(actual![0] == part)
    }
    
    func testIfRemovesPartProperly(){
        // Arrange
        let partToRemove = "MirrorRight"
        let jsonWithInvalidParts = """
        {
            "mainScreenText": "text",
            "selection":[
            {
                "id":"MirrorRight"
            },
            {
                "id":"MirrorLeft"
            },
            {
                "id":"invalidName2"
            }

            ]
        }
        """
        
        // Act
        sut?.createCollectionOfDamagedParts(json: jsonWithInvalidParts)
        sut?.removePart(partId: partToRemove)
        let actual = sut?.getCollectionOfDamagedParts()
        // Assert
        
        XCTAssert(actual!.count == 1)
        XCTAssert(actual![0].id == "MirrorLeft")
    }
    
    func testIfItdoesntAddInvalidPart(){
        // Arrange
        let invalidPart = Selection(newName: "invalidPart")
        
        // Act
        sut?.addPart(part: invalidPart)
        let actual = sut?.getCollectionOfDamagedParts()

        // Assert
        XCTAssert(actual?.count == 0)
        
    }
    
    func testIfOveritesCollection(){
        // Arrange
        let jsonWithOnePart = """
        {
            "mainScreenText": "text",
            "selection":[
            {
                "id":"MirrorRight"
            }
            ]
        }
        """
        sut?.createCollectionOfDamagedParts(json: jsonWithOnePart)
        let newJson = """
        {
            "mainScreenText": "text",
            "selection":[

            {
                "id":"Roof"
            }

            ]
        }
        """
        
        // Act
        
        let actual = sut?.createAndGetCollectionOfDamagedParts(json: newJson)
        
        // Assert
        XCTAssert(actual?.count == 1)
        XCTAssert(actual![0].id == "Roof")
    }
}

