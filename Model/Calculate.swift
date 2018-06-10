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
    
    // MARK: - Methods
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
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
        var total = 0
        for (enumerated, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[enumerated] == "+" {
                    total += number
                } else if operators[enumerated] == "-" {
                    total -= number
                } else if operators[enumerated] == "×" {
                    total *= number
                } else if operators[enumerated] == "÷" {
                    total /= number
                }
            }
        }
        return total
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
}
