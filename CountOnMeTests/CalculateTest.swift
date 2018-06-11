//
//  CalculateTest.swift
//  CountOnMeTests
//
//  Created by Lei et Matthieu on 11/06/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculateTest: XCTestCase {

    var calculate: Calculate!

    override func setUp() {
        super .setUp()
        calculate = Calculate()
    }

    func testGivenNoElementToCalculate_WhenAddToCalculate1Plus1_ThenTextToDisplay() {

        calculate.addNewNumber(1)
        calculate.addNewOperator("+")
        calculate.addNewNumber(1)

        XCTAssertEqual(calculate.calculText(), "1+1")
    }
}
