//
//  WalletViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var budget: Budget? = nil
    
    @IBOutlet weak var budgetLabel: UINavigationItem!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var walletTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTableView.delegate = self
        walletTableView.dataSource = self
        budgetLabel.title = "\((budget?.title)!) Wallet"
        incomeLabel.text = String(describing: (budget?.totalIncome)!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        walletTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (budget?.expenses?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = (budget?.expenses?[indexPath.row] as! Expense).store
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! CreateExpenseModalViewController
        nextVC.budget = budget
    }


}
