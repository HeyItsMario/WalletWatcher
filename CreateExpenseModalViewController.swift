//
//  CreateExpenseModalViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 6/19/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class CreateExpenseModalViewController: UIViewController {

    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var storeField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    var budget: Budget? = nil
    var budgetController = BudgetController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func enterTapped(_ sender: Any) {
        let cost = Decimal(string: costField.text!)
        budgetController.addExpense(amount: cost!, store: storeField.text!, description: descriptionField.text!, budget: budget!)
        self.presentingViewController?.viewWillAppear(true)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
