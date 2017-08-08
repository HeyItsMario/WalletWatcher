//
//  ExpenseDetailViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 7/12/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class ExpenseDetailViewController: UIViewController {

    @IBOutlet weak var storeLabel: UILabel! {
        didSet {
            storeLabel.text = expense?.store
        }
    }
    @IBOutlet weak var descLabel: UILabel! {
        didSet {
            descLabel.text = expense?.desc
        }
    }
    @IBOutlet weak var costLabel: UILabel! {
        didSet {
            costLabel.text = "$\((expense?.cost)!)"
        }
    }
    @IBOutlet var detailView: UIView! {
        didSet {
            detailView.layer.backgroundColor = UIColor.white.cgColor
            detailView.layer.cornerRadius = 5.0
            detailView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            detailView.layer.shadowOpacity = 0.9
        }
    }
    
    @IBOutlet var dismissButton: UIButton! {
        didSet {
            dismissButton.setTitleColor(themeColor, for: .normal)
            dismissButton.layer.borderWidth = 1.0
            dismissButton.layer.cornerRadius = 5.0
            dismissButton.layer.borderColor = themeColor.cgColor
        }
    }
    
    var expense: Expense? = nil
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
