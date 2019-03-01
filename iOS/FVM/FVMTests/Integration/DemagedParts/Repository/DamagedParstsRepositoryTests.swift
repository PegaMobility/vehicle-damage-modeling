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

class DamagedParstsRepositoryTests: XCTestCase {
    private var sut: DamagedPartsRepository?
    
    override func setUp() {
        sut = DamagedPartsRepository();
    }
    
    func testIfAddsElementsCorrecly() {
        // Arrange
        let part = Selection(newName: "ValidName")
        let expected = [part]
        
        // Act
        sut?.add(selection: part)
        let actual = sut?.getAll()
        
        // Assert
        XCTAssertEqual(expected, actual)
    }
    
    func testIfClearsCorreclty(){
        // Arrange
        let parts = [Selection(newName: "name"), Selection(newName: "nameOne"), Selection(newName: "nameTwo")]
        let expected = 0
        // Act
        sut?.add(selections: parts)
        sut?.clear()
        let actual = sut?.getAll().count
        
        // Assert
        XCTAssertEqual(expected, actual)
    }
    
    func testIfItDoesntDupliatePartsWithTheSameName() {
        // Arrange
        let duplicatedParts = [Selection(newName: "name"), Selection(newName: "name"), Selection(newName: "name"), Selection(newName: "name")]
        let expected = 1
        
        // Act
        sut?.add(selections: duplicatedParts)
        let actual = sut?.getAll().count
        
        // Assert
        XCTAssertEqual(actual, expected)
    }
}
