//
//  AddIncomeViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 6/23/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class AddIncomeViewController: UIViewController {
    
    var budgetController:BudgetController? = nil
    
    @IBOutlet weak var incomeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {
    
        budgetController?.addIncome(amount: Decimal(string: incomeTextField.text!)!)
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
}
