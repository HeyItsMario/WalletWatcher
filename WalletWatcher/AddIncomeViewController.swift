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
        
        enterButton.setTitleColor(themeColor, for: .normal)
        enterButton.layer.borderWidth = 1.0
        enterButton.layer.cornerRadius = 5.0
        enterButton.layer.borderColor = themeColor.cgColor
        
        
        cancelButton.setTitleColor(themeColor, for: .normal)
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.layer.borderColor = themeColor.cgColor
        

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = themeColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {
        
        // Adding income from the main view which means it adds to total income
        if fromSegue == "mainIncome" {
            budgetController.addIncome(amount: NSDecimalNumber(string: incomeTextField.text!))
        }
        
        // Adding income from the wallet view which means it adds to the budget's total
        if fromSegue == "walletIncome" {
            budgetController.addBudgetIncome(amount: NSDecimalNumber(string: incomeTextField.text!), budget: budget!)
        }
        
        
        performSegue(withIdentifier: "unwindSegueToMainView", sender: self)
        
    
    }
    

    
    
}
