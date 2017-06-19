//
//  MainViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var walletTableView: UITableView!
    
    var bgController:BudgetController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTableView.delegate = self
        walletTableView.dataSource = self
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        bgController = BudgetController(context: context)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        return cell
    }

}

