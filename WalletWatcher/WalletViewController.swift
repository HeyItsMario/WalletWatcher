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
    var budgetController = BudgetController.sharedInstance
    
    @IBOutlet weak var budgetLabel: UINavigationItem!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var walletTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTableView.delegate = self
        walletTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        walletTableView.reloadData()
        budgetLabel.title = "\((budget?.title)!) Wallet"
        let formatter = NumberFormatter()
        let income = (budget?.totalIncome)!
        formatter.numberStyle = .currency
        incomeLabel.text = formatter.string(from: income)
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
        
        if segue.identifier == "expenseSegue" {
            let nextVC = segue.destination as! CreateExpenseModalViewController
            nextVC.budget = budget
        }
        
        if segue.identifier == "addIncomeSegue" {
            let nextVC = segue.destination as! AddIncomeViewController
            nextVC.budget = budget
            nextVC.fromSegue = "walletIncome"
        }
        
    }
    
    @IBAction func unwindToWalletView(segue:UIStoryboardSegue) {
        walletTableView.reloadData()
        let formatter = NumberFormatter()
        let income = (budget?.totalIncome)!
        formatter.numberStyle = .currency
        incomeLabel.text = formatter.string(from: income)
    }


}
