//
//  DamagePartsServiceImplTests.swift
//  FVMTests
//
//  Created by Smykala, Szymon on 17/02/2019.
//  Copyright © 2019 Czajka, Kamil. All rights reserved.
//

import XCTest
@testable import FVM

class DamagePartsServiceImplTests: XCTestCase {

    
    private var parserMock = ParserMock();
    private var sut: DemagedPartsServiceImpl?
    
    override func setUp() {
        sut = DemagedPartsServiceImpl(parser: parserMock)
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
