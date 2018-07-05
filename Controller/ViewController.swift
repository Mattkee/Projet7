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

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Action
    @IBAction func tappedButton(_ sender: UIButton) {
        if let tagButton = sender.currentTitle {
            switch tagButton {
            case "=":
                total()
            case "+", "-", "×", "÷":
                checkError(tagButton)
                updateDisplay()
            case ".":
                checkDecimalError()
                updateDisplay()
            case "AC":
                calculate.clear()
                updateDisplay()
            case "⇐" :
                calculate.suppElement()
                updateDisplay()
            default:
                calculate.addNewElement(tagButton)
                updateDisplay()
            }
        }
    }
    // MARK: - Methods
    func total() {
        if checkExpressionError() == true {
            textView.text = calculate.calculateTotal()
        }
    }
    func updateDisplay() {
        textView.text = calculate.prepareText()
    }
}
// Alerte methods
extension ViewController {

    private func checkError(_ newElement: String) {
        switch calculate.canAddOperator {
        case .accepted:
            calculate.addNewElement(newElement)
        case .rejected(let error):
            presentAlert(with: error)
        }
    }

    private func checkExpressionError() -> Bool {
        switch calculate.isExpressionCorrect {
        case .accepted:
            return true
        case .rejected(let error):
            presentAlert(with: error)
            return false
        }
    }

    private func checkDecimalError() {
        switch calculate.decimalError {
        case .accepted:
            calculate.addNewElement(".")
        case .rejected(let error):
            presentAlert(with: error)
        }
    }

    private func presentAlert(with error: String) {
        let alerteVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerteVC.addAction(action)
        present(alerteVC, animated: true, completion: nil)
    }
}
