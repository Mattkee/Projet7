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

    var lastTap: Bool {
        return calculate.stringNumbers.last == "" && calculate.operators.count > 1
    }

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        let number = sender.tag
        calculate.addNewNumber(Double(number))
        updateDisplay()
    }

    @IBAction func calculateOperator(_ sender: UIButton) {
        let tagOperator = sender.currentTitle
        if tagOperator! == "+" {
            calculate.addNewOperator("+")
            updateDisplay()
        } else if tagOperator! == "-" {
            calculate.addNewOperator("-")
            updateDisplay()
        } else if tagOperator! == "×" {
            calculate.addNewOperator("×")
            updateDisplay()
        } else if tagOperator! == "÷" {
            calculate.addNewOperator("÷")
            updateDisplay()
        } else if tagOperator! == "=" {
            total()
        } else if tagOperator! == "AC" {
            calculate.clear()
            textView.text = "0"
            calculate.total = 0
            calculate.decimal = false
        } else if tagOperator! == "⇐" {
            if lastTap == true && textView.text != "0" {
                calculate.suppOperator()
                calculate.suppNumber()
                updateDisplay()
                calculate.checkDecimal()
            } else {
                if calculate.stringNumbers.count == 1 || calculate.operators.count == 1 {
                    calculate.clear()
                    textView.text = "0"
                    calculate.total = 0
                } else {
                    calculate.suppNumber()
                    calculate.stringNumbers.append("")
                    updateDisplay()
                    calculate.checkDecimal()
                }
            }
        }
    }

    @IBAction func tappedDecimal(_ sender: UIButton) {
        if calculate.decimal != true && lastTap != true {
            calculate.addDecimal()
            updateDisplay()
        }
    }

    // MARK: - Methods
    func updateDisplay() {
        let text = calculate.calculText()
        textView.text = text
    }

    func total() {
        if !isExpressionCorrect {
            return
        }
        let total = calculate.calculateTotal()
        if calculate.issue == true {
            textView.text = "Impossible de diviser par zero"
            calculate.clear()
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
