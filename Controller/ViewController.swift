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

    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.displayAlertDelegate = self
    }

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Action
    @IBAction func tappedButton(_ sender: UIButton) {
        if let tagButton = sender.currentTitle {
            switch tagButton {
            case "=":
                total()
            case "+", "-", "×", "÷":
                if calculate.canAddOperator {
                    calculate.addNewElement(tagButton)
                }
                updateDisplay()
            case ".":
                if calculate.decimalError {
                    calculate.addNewElement(".")
                }
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
        if calculate.isExpressionCorrect {
            textView.text = calculate.calculateTotal()
        }
    }
    func updateDisplay() {
        if calculate.prepareText() != "" {
            textView.text = calculate.prepareText()
        } else {
            textView.text = "0"
        }
    }
}

// MARK: - Alert Management
extension ViewController: DisplayAlert {
    func showAlert(title: String, message: String) {
        let alerteVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerteVC.addAction(action)
        present(alerteVC, animated: true, completion: nil)
    }
}
