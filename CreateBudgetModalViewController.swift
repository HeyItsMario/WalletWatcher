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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func enterTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let budget = Budget(context: context)
        budget.title = titleField.text
        budget.totalIncome = Decimal(string: incomeField.text!) as NSDecimalNumber?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
