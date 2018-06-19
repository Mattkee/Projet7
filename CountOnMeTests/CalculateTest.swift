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

    func testGivenNoElementToCalculate_WhenAddToCalculate1Plus1_ThenTextToDisplayIs1Plus1() {

        calculate.addNewNumber(1)
        calculate.addNewOperator("+")
        calculate.addNewNumber(1)

        XCTAssertEqual(calculate.calculText(), "1+1")
    }

    func testGivenElementToCalculateIs1Plus1_WhenCalculating1Plus1_ThenResultIs2() {

        calculate.addNewNumber(1)
        calculate.addNewOperator("+")
        calculate.addNewNumber(1)

        XCTAssertEqual(calculate.calculateTotal(), 2)
    }
    func testGivenNoElementToCalculate_WhenAddToCalculate2Minus1_ThenTextToDisplayIs2Minus1() {

        calculate.addNewNumber(2)
        calculate.addNewOperator("-")
        calculate.addNewNumber(1)

        XCTAssertEqual(calculate.calculText(), "2-1")
    }
    func testGivenElementToCalculateIs2Minus1_WhenCalculating2Minus1_ThenResultIs1() {

        calculate.addNewNumber(2)
        calculate.addNewOperator("-")
        calculate.addNewNumber(1)

        XCTAssertEqual(calculate.calculateTotal(), 1)
    }
    func testGivenElementToCalculateIs1Plus2multipliedBy2_WhenCalculating_ThenResultIs5() {
        calculate.addNewNumber(1)
        calculate.addNewOperator("+")
        calculate.addNewNumber(2)
        calculate.addNewOperator("×")
        calculate.addNewNumber(2)

        XCTAssertEqual(calculate.calculateTotal(), 5)
    }
    func testGivenElementToCalculateIs1Plus2dividedBy2_WhenCalculating_ThenResultIs2() {
        calculate.addNewNumber(1)
        calculate.addNewOperator("+")
        calculate.addNewNumber(2)
        calculate.addNewOperator("÷")
        calculate.addNewNumber(2)

        XCTAssertEqual(calculate.calculateTotal(), 2)
    }
    func testGivenElementToCalculateIs1Plus2dividedBy0_WhenCalculating_ThenNoResultDataIsDeletedAndThereAreAnIssue() {
        calculate.addNewNumber(1)
        calculate.addNewOperator("+")
        calculate.addNewNumber(2)
        calculate.addNewOperator("÷")
        calculate.addNewNumber(0)

        var element = false
        let total = calculate.calculateTotal()
        if let stringNumber = calculate.stringNumbers.last {
            if stringNumber.isEmpty {
                element = true
            }
        }

        XCTAssertEqual(total, 0)
        XCTAssertTrue(element)
        XCTAssertTrue(calculate.operators.count == 1)
        XCTAssertEqual(calculate.issue, true)
    }
    func testGivenElementToCalculateIs2Point2Plus2Point2_WhenAddNumber_ThenTextToDisplayIs2Point2Plus2Point2() {
        calculate.addNewNumber(2)
        calculate.addDecimal()
        calculate.addNewNumber(2)
        calculate.addNewOperator("+")
        calculate.addNewNumber(2)
        calculate.addDecimal()
        calculate.addNewNumber(2)

        XCTAssertEqual(calculate.calculText(), "2.2+2.2")
    }
    func testGivenElementToCalculateIs2Point2Plus2Point2_WhenCalculating_ThenResultIs4Point4() {
        calculate.addNewNumber(2)
        calculate.addDecimal()
        calculate.addNewNumber(2)
        calculate.addNewOperator("+")
        calculate.addNewNumber(2)
        calculate.addDecimal()
        calculate.addNewNumber(2)

        XCTAssertEqual(calculate.calculateTotal(), 4.4)
    }
    func testGivenTotalIs2Point2_WhenAddOperatorPlus_ThenTextToDisplayis2Point2Plus() {
        calculate.total = 2.2
        calculate.addNewOperator("+")

        XCTAssertEqual(calculate.calculText(), "2.2+")
    }
    func testGivenNoElementAddInCalculator_WhenAddDecimalPoint_ThenTextToDisplayIs0Point() {
        calculate.addDecimal()

        XCTAssertEqual(calculate.calculText(), "0.")
    }
    func testGivenTotalIs3_WhenAddDecimalPoint_ThenTextToDisplayIs3Point() {
        calculate.total = 3
        calculate.addDecimal()

        XCTAssertEqual(calculate.calculText(), "3.")
    }
    func testGivenTextToCalculateIs2Plus2_WhenDeleted2_ThenTextToDisplayIs2Plus() {
        calculate.addNewNumber(2)
        calculate.addNewOperator("+")
        calculate.addNewNumber(2)

        calculate.suppNumber()
        calculate.stringNumbers.append("")

        XCTAssertEqual(calculate.calculText(), "2+")
    }
    func testGivenTextToCalculateIs2Plus_WhenDeletedPlus_ThenTextToDisplayIs2() {
        calculate.addNewNumber(2)
        calculate.addNewOperator("+")

        calculate.suppOperator()

        XCTAssertEqual(calculate.calculText(), "2")
    }
}
