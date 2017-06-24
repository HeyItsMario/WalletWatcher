//
//  MainViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var budgetController = BudgetController()
    
    
    @IBOutlet weak var budgetTableView: UITableView!
    @IBOutlet var mainIncome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = budgetController.budgets[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetController.budgets.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        budgetController.fetchBudgets()
        budgetTableView.reloadData()
        mainIncome.text = String(describing: (budgetController.totalIncome?.total)!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = budgetController.budgets[indexPath.row]
        performSegue(withIdentifier: "walletSegue", sender: budget)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "walletSegue" {
            let nextVC = segue.destination as! WalletViewController
            nextVC.budget = sender as? Budget
        }
        
        if segue.identifier == "addIncomeSegue" {
            let nextVC = segue.destination as! AddIncomeViewController
            nextVC.budgetController = budgetController
        }
        
        
    }
    


}

