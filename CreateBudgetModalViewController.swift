//
//  CreateBudgetModalViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class CreateBudgetModalViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var incomeField: UITextField!
    @IBOutlet var titleField: UITextField!
    
    let budgetController = BudgetController.sharedInstance
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    @IBOutlet weak var createBudgetFormView: UIView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeField.delegate = self
        titleField.delegate = self
        
        
        
        createBudgetFormView.layer.backgroundColor = UIColor.white.cgColor
        createBudgetFormView.layer.cornerRadius = 5.0
        createBudgetFormView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        createBudgetFormView.layer.shadowOpacity = 0.9
        
        incomeField.layer.borderWidth = 1.0
        incomeField.layer.cornerRadius = 5.0
        incomeField.layer.borderColor = UIColor.lightGray.cgColor
        incomeField.attributedPlaceholder = NSAttributedString(string: incomeField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        incomeField.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        titleField.layer.borderWidth = 1.0
        titleField.layer.cornerRadius = 5.0
        titleField.layer.borderColor = UIColor.lightGray.cgColor
        titleField.attributedPlaceholder = NSAttributedString(string: titleField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        titleField.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.layer.borderColor = themeColor.cgColor
        cancelButton.setTitleColor(themeColor, for: .normal)
        
        enterButton.layer.borderWidth = 1.0
        enterButton.layer.cornerRadius = 5.0
        disableEnterButton(button: enterButton)

    }
    
    func valueChanged(sender: UITextField) {
        if sender.text! != "" && !incomeField.text!.isEmpty && !titleField.text!.isEmpty {
            enableEnterButton(button: enterButton)
        } else {
            disableEnterButton(button: enterButton)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = themeColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
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
    
    @IBAction func enterTapped(_ sender: Any) {
        view.endEditing(false)
        budgetController.createBudget(title: titleField.text!, amount: incomeField.text!)
        performSegue(withIdentifier: "unwindToMainViewFromBudget", sender: self)
    }

    @IBAction func cancelTapped(_ sender: Any) {
        view.endEditing(false)
        self.dismiss(animated: true, completion: nil)
    }
    
}



