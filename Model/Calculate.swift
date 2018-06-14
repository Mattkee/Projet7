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
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }

    func addNewOperator(_ newOperator: String) {
        operators.append(newOperator)
        stringNumbers.append("")
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

    func calculateTotal() -> Int {
        repeat {
           calculePreparationForMultiple()
        } while multiple == true

        repeat {
            calculePreparationForDivision()
        } while division == true

        var total = 0
        for (enumerated, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
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
                let total = Int(stringNumbers[enumerated-1])! * Int(stringNumber)!
                stringNumbers[enumerated-1] = String(total)
                operators.remove(at: enumerated)
                stringNumbers.remove(at: enumerated)
                return
        }
    }

    func calculePreparationForDivision() {
        for (enumerated, stringNumber) in stringNumbers.enumerated() where operators[enumerated] == "÷" {
            if Int(stringNumber)! == 0 {
                issue = true
                operators.remove(at: enumerated)
                stringNumbers.remove(at: enumerated)
                return
            } else {
                let total = Int(stringNumbers[enumerated-1])! / Int(stringNumber)!
                stringNumbers[enumerated-1] = String(total)
                operators.remove(at: enumerated)
                stringNumbers.remove(at: enumerated)
                return
            }
        }
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        issue = false
    }
}
