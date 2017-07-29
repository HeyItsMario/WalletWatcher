//
//  CreateBudgetModalViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class CreateBudgetModalViewController: UIViewController {

    @IBOutlet var incomeField: UITextField!
    @IBOutlet var titleField: UITextField!
    
    let budgetController = BudgetController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func enterTapped(_ sender: Any) {
        budgetController.createBudget(title: titleField.text!, amount: incomeField.text!)
        performSegue(withIdentifier: "unwindToMainViewFromBudget", sender: self)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
