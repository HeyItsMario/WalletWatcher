//
//  AddIncomeViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 6/23/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class AddIncomeViewController: UIViewController {
    
    @IBOutlet weak var incomeTextField: UITextField!
    var budgetController = BudgetController.sharedInstance
    var budget: Budget? = nil
    var fromSegue:String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {

        // Adding income from the main view which means it adds to total income
        if fromSegue == "mainIncome" {
            budgetController.addIncome(amount: Decimal(string: incomeTextField.text!)!)
        }
        
        // Adding income from the wallet view which means it adds to the budget's total
        if fromSegue == "walletIncome" {
            budgetController.addBudgetIncome(amount: Decimal(string: incomeTextField.text!)!, budget: budget!)
        }
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
}
