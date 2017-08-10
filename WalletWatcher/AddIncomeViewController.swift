//
//  AddIncomeViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 6/23/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit


class AddIncomeViewController: UIViewController, UITextFieldDelegate {
    
    
    var budgetController = BudgetController.sharedInstance
    var budget: Budget? = nil
    var fromSegue:String? = nil
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    @IBOutlet weak var incomeTextField: UITextField! {
        didSet {
            incomeTextField.placeholder = "$0.00"
            incomeTextField.layer.borderWidth = 1.0
            incomeTextField.layer.cornerRadius = 5.0
            incomeTextField.layer.borderColor = UIColor.lightGray.cgColor
            incomeTextField.attributedPlaceholder = NSAttributedString(string: incomeTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        }
    }
    
    @IBOutlet var backgroundView: UIView! {
        didSet {
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = backgroundView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundView.insertSubview(blurEffectView, at: 0)
            
        }
    }
    
    @IBOutlet var headerLabel: UILabel! {
        didSet {
            headerLabel.text = "Add Income"
            headerLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
            headerLabel.addBottomBorderWithColor(color: UIColor.lightGray, width: 1)
        }
    }
    
    @IBOutlet weak var enterButton: UIButton! {
        didSet {
            enterButton.setTitleColor(UIColor.lightGray, for: .normal)
            enterButton.layer.borderWidth = 1.0
            enterButton.layer.cornerRadius = 5.0
            disableEnterButton(button: enterButton)
        }
    }
    
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.setTitleColor(themeColor, for: .normal)
            cancelButton.layer.borderWidth = 1.0
            cancelButton.layer.cornerRadius = 5.0
            cancelButton.layer.borderColor = themeColor.cgColor
        }
    }
    @IBOutlet weak var addIncomeFormView: UIView! {
        didSet {
            addIncomeFormView.layer.backgroundColor = UIColor.white.cgColor
            addIncomeFormView.alpha = 1
            addIncomeFormView.layer.cornerRadius = 5.0
            addIncomeFormView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            addIncomeFormView.layer.shadowOpacity = 0.9
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeTextField.delegate = self
        incomeTextField.addTarget(self, action: #selector(valueChanged(sender:)), for: .editingChanged)
        incomeTextField.becomeFirstResponder()
        
    }
    
    func valueChanged(sender: UITextField) {
        if sender.text! != "" && !incomeTextField.text!.isEmpty {
            enableEnterButton(button: enterButton)
        } else {
            disableEnterButton(button: enterButton)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = themeColor.cgColor
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        incomeTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {
        incomeTextField.resignFirstResponder()
        budgetController.addBudgetIncome(amount: NSDecimalNumber(string: incomeTextField.text!), budget: budget!)
        performSegue(withIdentifier: "unwindToWalletView", sender: self)
        
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
    
    
}

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}

