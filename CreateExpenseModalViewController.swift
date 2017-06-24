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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func enterTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let expense = Expense(context: context)
        expense.cost = Decimal(string: costField.text!) as NSDecimalNumber?
        expense.store = storeField.text
        expense.desc = descriptionField.text
        budget?.addToExpenses(expense)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
