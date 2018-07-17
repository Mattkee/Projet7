//
//  Calculate.swift
//  CountOnMe
//
//  Created by Lei et Matthieu on 10/06/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

protocol DisplayAlert {
    func showAlert(title: String, message: String)
}

class Calculate {
    // MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var total = 0.0
    var displayAlertDelegate: DisplayAlert?

    var priorOperator: Bool {
        for enumerated in operators.indices where operators[enumerated] == "×" || operators[enumerated] == "÷" {
            return true
        }
        return false
    }
    var lastTapIsOperatorOrPoint: Bool {
        let lastElement = stringNumbers.last
        return lastElement!.last == "." || (stringNumbers.last == "" && operators.count > 1)
    }
    var isDecimal: Bool {
        let lastElement = stringNumbers.last
        return lastElement!.contains(".")
    }
    var isDivisionError: Bool {
        for (enumerated, stringNumber) in stringNumbers.enumerated() where operators[enumerated] == "÷" {
            return Double(stringNumber)! == 0
        }
        return false
    }
}

// MARK: - Calculations Methods
extension Calculate {
    func addNewElement(_ newElement: String) {
        switch newElement {
        case "+", "-", "×", "÷":
            if total == 0.0 {
                operators.append(newElement)
                stringNumbers.append("")
            } else {
                addStringNumber(String(total))
                total = 0.0
                operators.append(newElement)
                stringNumbers.append("")
            }
        case ".":
            if total == 0.0 {
                addDecimal()
            } else if total != 0.0 {
                if String(total) == String(Int(total))+".0" {
                    addStringNumber(String(Int(total)))
                    total = 0.0
                    addDecimal()
                } else {
                    total = 0.0
                    addDecimal()
                }
            }
        default:
            total = 0.0
            addStringNumber(newElement)
        }
    }

    func addStringNumber(_ newElement: String) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newElement)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }

    func addDecimal() {
        if let stringNumber = stringNumbers.last {
            if stringNumber == "" {
                addStringNumber("0")
                addStringNumber(".")
            } else {
                addStringNumber(".")
            }
        }
    }

    func suppElement() {
        if lastTapIsOperatorOrPoint == true {
            operators.remove(at: operators.count-1)
            stringNumbers.remove(at: stringNumbers.count-1)
        } else {
            if stringNumbers.count == 1 || operators.count == 1 {
                clear()
            } else {
                stringNumbers.remove(at: stringNumbers.count-1)
                stringNumbers.append("")
            }
        }
    }

    func prepareText() -> String {
        var text = ""
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += stringNumber
        }
        return text
    }

    func calculateTotal() -> String {
        total = 0.0
        var textTotal: String
        if isDivisionError {
            let textTotal = "Impossible de diviser par zero"
            clear()
            return textTotal
        }
        calculPreparation()
        if String(total).count > 12 {
            let roundedTotal = Double(round(total*1000)/1000)
            textTotal = prepareText() + "=" + String(roundedTotal)
        } else if String(total) == String(Int(total))+".0" {
            textTotal = prepareText() + "=" + String(Int(total))
        } else {
            textTotal = prepareText() + "=" + String(total)
        }
        clear()
        return textTotal
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}

// MARK: - Calculation preparation Methods
extension Calculate {
    func calculPreparation() {
        let safeInitStringNumbers = stringNumbers
        let safeInitOperators = operators

        repeat {
            for (enumerated, stringNumber) in stringNumbers.enumerated() {
                if operators[enumerated] == "×" {
                    complexCalculation("×", enumerated, stringNumber)
                } else if operators[enumerated] == "÷" {
                    complexCalculation("÷", enumerated, stringNumber)
                }
            }
        } while priorOperator
        easyCalculation()
        stringNumbers = safeInitStringNumbers
        operators = safeInitOperators
    }

    func easyCalculation() {
        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[index] == "+" {
                    total += number
                } else if operators[index] == "-" {
                    total -= number
                }
            }
        }
    }

    func complexCalculation(_ stringOperator: String, _ enumerated: Int, _ stringNumber: String) {

        let numberOne = Double(stringNumbers[enumerated-1])!
        let numberTwo = Double(stringNumber)!
        let totalNumber: Double
        if stringOperator == "×" {
            totalNumber = numberOne * numberTwo
            stringNumbers[enumerated-1] = String(totalNumber)
        } else {
            totalNumber = numberOne / numberTwo
            stringNumbers[enumerated-1] = String(totalNumber)
        }
        operators.remove(at: enumerated)
        stringNumbers.remove(at: enumerated)
    }
}

// MARK: - Alert management properties
extension Calculate {

    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    displayAlertDelegate?.showAlert(title: "zero", message: "Démarrez un nouveau calcul !")
                } else {
                    displayAlertDelegate?.showAlert(title: "impossible calculation", message: "Entrez une expression correcte !")
                }
                return false
            }
        }
        return true
    }
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty && total == 0.0 || lastTapIsOperatorOrPoint {
                displayAlertDelegate?.showAlert(title: "operator error", message: "Expression incorrecte !")
                return false
            }
        }
        return true
    }
    var decimalError: Bool {
        if isDecimal || lastTapIsOperatorOrPoint {
            displayAlertDelegate?.showAlert(title: "decimal error", message: "Expression incorrecte !")
            return false
        }
        return true
    }
}
