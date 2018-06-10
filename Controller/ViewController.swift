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
            if stringNumber.isEmpty {
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
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        let number = sender.tag
        calculate.addNewNumber(number)
        updateDisplay()
    }
    
    @IBAction func calculateOperator(_ sender: UIButton) {
        let tagOperator = sender.currentTitle
        if tagOperator! == "+" {
            calculate.operators.append("+")
            calculate.stringNumbers.append("")
            updateDisplay()
        } else if tagOperator! == "-" {
            calculate.operators.append("-")
            calculate.stringNumbers.append("")
            updateDisplay()
        } else if tagOperator! == "×" {
            calculate.operators.append("×")
            calculate.stringNumbers.append("")
            updateDisplay()
        } else if tagOperator! == "÷" {
            calculate.operators.append("÷")
            calculate.stringNumbers.append("")
            updateDisplay()
        } else if tagOperator! == "=" {
            total()
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
        textView.text = textView.text + "=\(total)"
        calculate.clear()
    }
}
