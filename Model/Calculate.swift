//
//  Calculate.swift
//  CountOnMe
//
//  Created by Lei et Matthieu on 10/06/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculate {
    // MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var total: Double = 0
    var multiple: Bool {
        for enumerated in operators.indices where operators[enumerated] == "×" {
            return true
        }
        return false
    }
    var division: Bool {
        for enumerated in operators.indices where operators[enumerated] == "÷" {
            return true
        }
        return false
    }
    var issue = false

    // MARK: - Methods
    func addNewNumber(_ newNumber: Double) {
        if String(newNumber) == String(Int(newNumber))+".0" {
            if let stringNumber = stringNumbers.last {
                var stringNumberMutable = stringNumber
                stringNumberMutable += "\(Int(newNumber))"
                stringNumbers[stringNumbers.count-1] = stringNumberMutable
            }
        } else {
            if let stringNumber = stringNumbers.last {
                var stringNumberMutable = stringNumber
                stringNumberMutable += "\(newNumber)"
                stringNumbers[stringNumbers.count-1] = stringNumberMutable
            }
        }
    }

    func addNewOperator(_ newOperator: String) {
        if operators.count == 1 && total != 0 {
            addNewNumber(total)
            total = 0
            operators.append(newOperator)
            stringNumbers.append("")
        } else {
            operators.append(newOperator)
            stringNumbers.append("")
        }
    }

    func addDecimal() {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                addNewNumber(0)
                addPoint()
                total = 0
            } else if operators.count == 1 && total != 0 {
                addNewNumber(total)
                addPoint()
                total = 0
            } else {
                addPoint()
            }
        }
    }

    func addPoint() {
        stringNumbers[stringNumbers.count-1] = stringNumbers[stringNumbers.count-1]+"."
    }

    func calculText() -> String {
        var text = ""
        for (number, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if number > 0 {
                text += operators[number]
            }
            // Add number
            text += stringNumber
        }
        return text
    }

    func calculateTotal() -> Double {
        repeat {
           calculePreparationForMultiple()
        } while multiple == true

        repeat {
            calculePreparationForDivision()
        } while division == true

        for (enumerated, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[enumerated] == "+" {
                    total += number
                } else if operators[enumerated] == "-" {
                    total -= number
                }
            }
        }
        return total
    }

    func calculePreparationForMultiple() {
        for (enumerated, stringNumber) in stringNumbers.enumerated() where operators[enumerated] == "×" {
                let total = Double(stringNumbers[enumerated-1])! * Double(stringNumber)!
                stringNumbers[enumerated-1] = String(total)
                operators.remove(at: enumerated)
                stringNumbers.remove(at: enumerated)
                return
        }
    }

    func calculePreparationForDivision() {
        for (enumerated, stringNumber) in stringNumbers.enumerated() where operators[enumerated] == "÷" {
            if Double(stringNumber)! == 0 {
                clear()
                issue = true
                return
            } else {
                let total = Double(stringNumbers[enumerated-1])! / Double(stringNumber)!
                stringNumbers[enumerated-1] = String(total)
                operators.remove(at: enumerated)
                stringNumbers.remove(at: enumerated)
                return
            }
        }
    }
    func suppOperator() {
        let indexOperator = operators.count
        operators.remove(at: indexOperator-1)
    }
    func suppNumber() {
        let indexNumber = stringNumbers.count
        stringNumbers.remove(at: indexNumber-1)
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        issue = false
    }
}
