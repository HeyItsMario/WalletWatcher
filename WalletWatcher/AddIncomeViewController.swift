//
//  AddIncomeViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 6/23/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit


class AddIncomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var incomeTextField: UITextField!
    var budgetController = BudgetController.sharedInstance
    var budget: Budget? = nil
    var fromSegue:String? = nil
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addIncomeFormView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeTextField.delegate = self
        
        addIncomeFormView.layer.backgroundColor = UIColor.white.cgColor
        addIncomeFormView.layer.cornerRadius = 5.0
        addIncomeFormView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        addIncomeFormView.layer.shadowOpacity = 0.9
        
        
        incomeTextField.placeholder = "$0.00"
        incomeTextField.layer.borderWidth = 1.0
        incomeTextField.layer.cornerRadius = 5.0
        incomeTextField.layer.borderColor = UIColor.lightGray.cgColor
        incomeTextField.attributedPlaceholder = NSAttributedString(string: incomeTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        
        
        enterButton.setTitleColor(UIColor.lightGray, for: .normal)
        enterButton.layer.borderWidth = 1.0
        enterButton.layer.cornerRadius = 5.0
        disableEnterButton(button: enterButton)
        
        
        cancelButton.setTitleColor(themeColor, for: .normal)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.layer.borderColor = themeColor.cgColor
        

    }
    
    func valueChanged() {
        print("test")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = themeColor.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // If the location is at 0 and the textfield is not empty this means
        // that we had entered a value but then deleted it. textfield is now empty.
        if range.location == 0 && textField.text!.isEmpty == false {
            disableEnterButton(button: enterButton)
        } else {
            enableEnterButton(button: enterButton)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        if !textField.text!.isEmpty {
            enterButton.isEnabled = true
            enterButton.setTitleColor(themeColor, for: .normal)
            enterButton.layer.borderColor = themeColor.cgColor
        }
        
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {
        // Adding income from the wallet view which means it adds to the budget's total
        budgetController.addBudgetIncome(amount: NSDecimalNumber(string: incomeTextField.text!), budget: budget!)
        performSegue(withIdentifier: "unwindSegueToMainView", sender: self)
        
    }
    
    func enableEnterButton(button: UIButton) {
        button.isEnabled = true
        button.layer.borderColor = themeColor.cgColor
        button.setTitleColor(themeColor, for: .normal)
    }
    
    func disableEnterButton(button: UIButton) {
        button.isEnabled = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    
}
