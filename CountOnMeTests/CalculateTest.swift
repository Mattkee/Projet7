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

    func checkExpressionError() -> String {
        switch calculate.isExpressionCorrect {
        case .accepted:
            return ""
        case .rejected(let error):
            return error
        }
    }

    func checkDecimalError() -> String {
        switch calculate.decimalError {
        case .accepted:
            return ""
        case .rejected(let error):
            return error
        }
    }

    func checkError(_ newElement: String) -> String {
        switch calculate.canAddOperator {
        case .accepted:
            return ""
        case .rejected(let error):
            return error
        }
    }

    func testGivenNoElementToCalculate_WhenAddToCalculate1Plus1_ThenTextToDisplayIs1Plus1() {

        calculate.addNewElement("1")
        calculate.addNewElement("+")
        calculate.addNewElement("1")

        XCTAssertEqual(calculate.prepareText(), "1+1")
    }

    func testGivenElementToCalculateIs1Plus1_WhenCalculating1Plus1_ThenResultIs2() {

        calculate.addNewElement("1")
        calculate.addNewElement("+")
        calculate.addNewElement("1")

        XCTAssertEqual(calculate.calculateTotal(), "1+1=2")
    }
    func testGivenNoElementToCalculate_WhenAddToCalculate2Minus1_ThenTextToDisplayIs2Minus1() {

        calculate.addNewElement("2")
        calculate.addNewElement("-")
        calculate.addNewElement("1")

        XCTAssertEqual(calculate.prepareText(), "2-1")
    }
    func testGivenElementToCalculateIs2Minus1_WhenCalculating2Minus1_ThenResultIs1() {

        calculate.addNewElement("2")
        calculate.addNewElement("-")
        calculate.addNewElement("1")

        XCTAssertEqual(calculate.calculateTotal(), "2-1=1")
    }
    func testGivenElementToCalculateIs1Plus2multipliedBy2_WhenCalculating_ThenResultIs5() {
        calculate.addNewElement("1")
        calculate.addNewElement("+")
        calculate.addNewElement("2")
        calculate.addNewElement("×")
        calculate.addNewElement("2")

        XCTAssertEqual(calculate.calculateTotal(), "1+2×2=5")
    }
    func testGivenElementToCalculateIs1Plus2dividedBy2_WhenCalculating_ThenResultIs2() {
        calculate.addNewElement("1")
        calculate.addNewElement("+")
        calculate.addNewElement("2")
        calculate.addNewElement("÷")
        calculate.addNewElement("2")

        XCTAssertEqual(calculate.calculateTotal(), "1+2÷2=2")
    }
    func testGivenElementToCalculateIs1Plus2dividedBy0_WhenCalculating_ThenNoResultDataIsDeletedAndThereAreAnIssue() {
        calculate.addNewElement("1")
        calculate.addNewElement("+")
        calculate.addNewElement("2")
        calculate.addNewElement("÷")
        calculate.addNewElement("0")

        var element = false
        let total = calculate.calculateTotal()
        if let stringNumber = calculate.stringNumbers.last {
            if stringNumber.isEmpty {
                element = true
            }
        }

        XCTAssertEqual(total, "Impossible de diviser par zero")
        XCTAssertTrue(element)
        XCTAssertTrue(calculate.operators.count == 1)
    }
    func testGivenNoElementToCalculate_WhenAddElementToCalculateIs2Point2Plus2Point2_ThenTextToDisplayIs2Point2Plus2Point2() {
        calculate.addNewElement("2")
        calculate.addNewElement(".")
        calculate.addNewElement("2")
        calculate.addNewElement("+")
        calculate.addNewElement("2")
        calculate.addNewElement(".")
        calculate.addNewElement("2")

        XCTAssertEqual(calculate.prepareText(), "2.2+2.2")
    }
    func testGivenElementToCalculateIs2Point2Plus2Point2_WhenCalculating_ThenResultIs4Point4() {
        calculate.addNewElement("2")
        calculate.addNewElement(".")
        calculate.addNewElement("2")
        calculate.addNewElement("+")
        calculate.addNewElement("2")
        calculate.addNewElement(".")
        calculate.addNewElement("2")

        XCTAssertEqual(calculate.calculateTotal(), "2.2+2.2=4.4")
    }
    func testGivenTotalIs2Point2_WhenAddOperatorPlus_ThenTextToDisplayis2Point2Plus() {
        calculate.total = 2.2
        calculate.addNewElement("+")

        XCTAssertEqual(calculate.prepareText(), "2.2+")
    }
    func testGivenNoElementAddInCalculator_WhenAddDecimalPoint_ThenTextToDisplayIs0Point() {
        calculate.addNewElement(".")

        XCTAssertEqual(calculate.prepareText(), "0.")
    }
    func testGivenTotalIs3_WhenAddDecimalPoint_ThenTextToDisplayIs3Point() {
        calculate.total = 3
        calculate.addNewElement(".")

        XCTAssertEqual(calculate.prepareText(), "3.")
    }
    func testGivenTextToCalculateIs2Plus2_WhenDeleted2_ThenTextToDisplayIs2Plus() {
        calculate.addNewElement("2")
        calculate.addNewElement("+")
        calculate.addNewElement("2")

        calculate.suppElement()

        XCTAssertEqual(calculate.prepareText(), "2+")
    }
    func testGivenTextToCalculateIs2Plus_WhenDeletedPlus_ThenTextToDisplayIs2() {
        calculate.addNewElement("2")
        calculate.addNewElement("+")

        calculate.suppElement()

        XCTAssertEqual(calculate.prepareText(), "2")
    }
    func testGivenElementToCalculateIs50DividedBy3Point2_WhenCalculating_ThenResultIs1Point553() {
        calculate.addNewElement("50")
        calculate.addNewElement("÷")
        calculate.addNewElement("32.2")

        XCTAssertEqual(calculate.calculateTotal(), "50÷32.2=1.553")
    }
    func testGivenTotalIs3Point2_WhenAddDecimalPoint_ThenResultIs0Point() {
        calculate.total = 3.2
        calculate.addNewElement(".")

        XCTAssertEqual(calculate.prepareText(), "0.")
    }
    func testGivenElementToCalculateIs3_WhenResetAllElement_ThenThereIsNoElement() {
        calculate.addNewElement("3")
        calculate.suppElement()

        var arrayIsEmpty = false
        if calculate.stringNumbers.count == 1 {
            if let stringNumber = calculate.stringNumbers.last {
                if stringNumber.isEmpty {
                    arrayIsEmpty = true
                }
            }
        }

        XCTAssertTrue(arrayIsEmpty)
    }
    func testGivenNoElementToCalculate_WhenCalculating_ThenTextForAlerteIsDémarrezUnNouveauCalcul() {

        let isExpressionCorrect = checkExpressionError()

        XCTAssertEqual("Démarrez un nouveau calcul !", isExpressionCorrect)
    }
    func testGivenElementToCalculateIs2Plus_WhenCalculating_ThenTextForAlerteIsEntrezUneExpressionCorrecte() {
        calculate.addNewElement("2")
        calculate.addNewElement("+")

        let isExpressionCorrect = checkExpressionError()

        XCTAssertEqual("Entrez une expression correcte !", isExpressionCorrect)
    }
    func testGivenElementToCalculateIs2Plus2_WhenCalculating_ThenThereIsNoAlert() {
        calculate.addNewElement("2")
        calculate.addNewElement("+")
        calculate.addNewElement("2")

        let isExpressionCorrect = checkExpressionError()

        XCTAssertEqual("", isExpressionCorrect)
    }
    func testGivenElementToCalculateIs2Point_WhenObserveIsDecimal_ThenTextForAlerteIsExpressionCorrecte() {
        calculate.addNewElement("2")
        calculate.addNewElement(".")

        let isDecimalError = checkDecimalError()

        XCTAssertEqual("Expression incorrecte !", isDecimalError)
    }
    func testGivenElementToCalculateIs2_WhenObserveIsDecimal_ThenThereIsNoAlert() {
        calculate.addNewElement("2")

        let isDecimalError = checkDecimalError()

        XCTAssertEqual("", isDecimalError)
    }
    func testGivenElementToCalculateIs2Plus_WhenObserveCanAddOperator_ThenTextForAlerteIsExpressionIncorrecte() {
        calculate.addNewElement("2")
        calculate.addNewElement("+")

        let canAddOperator = checkError("+")

        XCTAssertEqual("Expression incorrecte !", canAddOperator)
    }
    func testGivenElementToCalculateIs2_WhenObserveCanAddOperator_ThenThereIsNoAlert() {
        calculate.addNewElement("2")

        let canAddOperator = checkError("+")

        XCTAssertEqual("", canAddOperator)
    }
}
