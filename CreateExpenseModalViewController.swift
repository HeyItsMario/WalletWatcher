//
//  CreateExpenseModalViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 6/19/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class CreateExpenseModalViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var storeField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var createExpenseFormView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    var budget: Budget? = nil
    var budgetController = BudgetController.sharedInstance
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costField.delegate = self
        storeField.delegate = self
        descriptionField.delegate = self
        
        costField.layer.borderWidth = 1.0
        costField.layer.cornerRadius = 5.0
        costField.layer.borderColor = UIColor.lightGray.cgColor
        
        storeField.layer.borderWidth = 1.0
        storeField.layer.cornerRadius = 5.0
        storeField.layer.borderColor = UIColor.lightGray.cgColor
        
        descriptionField.layer.borderWidth = 1.0
        descriptionField.layer.cornerRadius = 5.0
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        
        createExpenseFormView.layer.backgroundColor = UIColor.white.cgColor
        createExpenseFormView.layer.cornerRadius = 5.0
        createExpenseFormView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        createExpenseFormView.layer.shadowOpacity = 0.9
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.layer.borderColor = themeColor.cgColor
        cancelButton.setTitleColor(themeColor, for: .normal)
        
        enterButton.layer.borderWidth = 1.0
        enterButton.layer.cornerRadius = 5.0
        enterButton.layer.borderColor = themeColor.cgColor
        enterButton.setTitleColor(themeColor, for: .normal)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = themeColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func enterTapped(_ sender: Any) {
        let cost = NSDecimalNumber(string: costField.text!)
        budgetController.addExpense(amount: cost, store: storeField.text!, description: descriptionField.text!, budget: budget!)
        performSegue(withIdentifier: "unwindToWalletView", sender: self)
        
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
