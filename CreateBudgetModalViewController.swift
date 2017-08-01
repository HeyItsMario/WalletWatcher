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
    
    
    @IBOutlet weak var createBudgetFormView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
        
        createBudgetFormView.layer.backgroundColor = UIColor.white.cgColor
        createBudgetFormView.layer.cornerRadius = 5.0
        
        incomeField.layer.borderWidth = 1.0
        incomeField.layer.cornerRadius = 5.0
        incomeField.layer.borderColor = borderColor.cgColor
        incomeField.attributedPlaceholder = NSAttributedString(string: incomeField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        titleField.layer.borderWidth = 1.0
        titleField.layer.cornerRadius = 5.0
        titleField.layer.borderColor = borderColor.cgColor
        titleField.attributedPlaceholder = NSAttributedString(string: titleField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.layer.borderColor = borderColor.cgColor
        cancelButton.setTitleColor(borderColor, for: .normal)
        
        enterButton.layer.borderWidth = 1.0
        enterButton.layer.cornerRadius = 5.0
        enterButton.layer.borderColor = borderColor.cgColor
        enterButton.setTitleColor(borderColor, for: .normal)
        
        
        
        
    }


    @IBAction func enterTapped(_ sender: Any) {
        budgetController.createBudget(title: titleField.text!, amount: incomeField.text!)
        performSegue(withIdentifier: "unwindToMainViewFromBudget", sender: self)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
