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

class DamagePartsValidatorTests: XCTestCase {
    private var namesProviderMock: DamagedPartsNamesProviderProtocol?
    private var sut: DamagedPartsValidator?
    
    override func setUp() {
        namesProviderMock = ProviderMock(names: [String]())
        sut = DamagedPartsValidator(provider: namesProviderMock!)
    }
    
    func testIfValidatesCorrectly(){
        // Arrange
        let validNames = ["Mirror", "Roof", "ValidName"]
        let selectionToValidate = [Selection(newName: "Mirror"), Selection(newName: "InvalidPart")]
        
        namesProviderMock = ProviderMock(names: validNames)
        sut = DamagedPartsValidator(provider: namesProviderMock!)
    
        let expected = [Selection(newName: "Mirror")]
    
        // Act
        let actual = sut?.validate(partsNames: selectionToValidate)
        
        // Assert
        XCTAssertEqual(expected, actual)
    }
}
