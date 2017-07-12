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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
