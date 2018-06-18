//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let calculate = Calculate()

    var isExpressionCorrect: Bool {
        if let stringNumber = calculate.stringNumbers.last {
            if stringNumber.isEmpty || calculate.stringNumbers.count < 2 {
                if calculate.stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = calculate.stringNumbers.last {
            if stringNumber.isEmpty {
                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }

    var lastTapIsOperator: Bool {
        return calculate.stringNumbers.last == "" && calculate.operators.count > 1
    }
    var lastTapIsPoint: Bool {
        if calculate.stringNumbers.count != 0 {
            if let lastElement = calculate.stringNumbers.last {
                return lastElement.last == "."
            }
        }
        return false
    }

    var isDecimal: Bool {
        if calculate.stringNumbers.count != 0 {
            if let lastElement = calculate.stringNumbers.last {
                return lastElement.contains(".")
            }
        }
        if calculate.total != 0 {
            let total = calculate.total
            if String(total) != String(Int(total))+".0" {
                return true
            }
        }
        return false
    }

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        let number = sender.tag
        calculate.addNewNumber(Double(number))
        updateDisplay()
        if calculate.total != 0 {
            calculate.total = 0
        }
    }

    @IBAction func calculateOperator(_ sender: UIButton) {
        if let tagOperator = sender.currentTitle {
            if lastTapIsOperator != true {
                switch tagOperator {
                case "+" :
                    addOperator("+")
                case "-" :
                    addOperator("-")
                case "×" :
                    addOperator("×")
                case "÷" :
                    addOperator("÷")
                default:
                    total()
                }
            }
        }
    }

    @IBAction func additionalAction(_ sender: UIButton) {
        if let tagOperator = sender.currentTitle {
            switch tagOperator {
            case "AC" :
                calculate.clear()
                textView.text = "0"
                calculate.total = 0
            case "⇐" :
                if lastTapIsOperator == true && textView.text != "0" {
                    calculate.suppOperator()
                    calculate.suppNumber()
                    updateDisplay()
                } else {
                    if calculate.stringNumbers.count == 1 || calculate.operators.count == 1 {
                        calculate.clear()
                        textView.text = "0"
                        calculate.total = 0
                    } else {
                        calculate.suppNumber()
                        calculate.stringNumbers.append("")
                        updateDisplay()
                    }
                }
            default :
                return
            }
        }
    }

    @IBAction func tappedDecimal(_ sender: UIButton) {
        if isDecimal || lastTapIsOperator {
            return
        } else {
            calculate.addDecimal()
            updateDisplay()
        }
    }

    // MARK: - Methods
    func updateDisplay() {
        let text = calculate.calculText()
        textView.text = text
    }

    func addOperator(_ sender: String) {
        if lastTapIsPoint {
            calculate.addNewNumber(0)
        }
        calculate.addNewOperator(sender)
        updateDisplay()
    }

    func total() {
        if !isExpressionCorrect {
            return
        }
        let total = calculate.calculateTotal()
        if calculate.issue == true {
            textView.text = "Impossible de diviser par zero"
            calculate.clear()
            calculate.total = 0
        } else {
            if String(total) == String(Int(total))+".0" {
                textView.text = textView.text + "=\(Int(total))"
                calculate.clear()
            } else {
                textView.text = textView.text + "=\(total)"
                calculate.clear()
            }
        }
    }
}
