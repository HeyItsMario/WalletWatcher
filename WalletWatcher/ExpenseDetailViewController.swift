//
//  ExpenseDetailViewController.swift
//  WalletWatcher
//
//  Created by Cordova, Mario A on 7/12/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class ExpenseDetailViewController: UIViewController {

    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    var expense: Expense? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeLabel.text = expense?.store
        descLabel.text = expense?.desc
        costLabel.text = "$\((expense?.cost)!)"
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
