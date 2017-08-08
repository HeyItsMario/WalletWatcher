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
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    @IBOutlet weak var budgetLabel: UINavigationItem!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var walletTableView: UITableView!
    
    @IBOutlet weak var addIncomeButton: UIButton! {
        didSet {
            addIncomeButton.layer.borderWidth = 1.0
            addIncomeButton.layer.cornerRadius = 5.0
            addIncomeButton.layer.borderColor = themeColor.cgColor
            addIncomeButton.setTitleColor(themeColor, for: .normal)
        }
    }
    
    @IBOutlet weak var addExpenseButton: UIButton! {
        didSet {
            addExpenseButton.layer.borderWidth = 1.0
            addExpenseButton.layer.cornerRadius = 5.0
            addExpenseButton.layer.borderColor = themeColor.cgColor
            addExpenseButton.setTitleColor(themeColor, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletTableView.delegate = self
        walletTableView.dataSource = self
        walletTableView.tableFooterView = UIView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        walletTableView.reloadData()
        budgetLabel.title = "\((budget?.title)!) Wallet"
        refreshBudgetIncomeLabel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (budget?.expenses?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: (budget?.expenses?[indexPath.row] as! Expense).date! as Date)
        cell.textLabel?.text = (budget?.expenses?[indexPath.row] as! Expense).store!
        cell.detailTextLabel?.text = dateString
        cell.textLabel?.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        cell.detailTextLabel?.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            budgetController.deleteExpense(budget: budget!, expense: budget!.expenses![indexPath.row] as! Expense)
            walletTableView.reloadData()
            refreshBudgetIncomeLabel()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showExpenseSegue", sender: budget?.expenses?[indexPath.row])
        walletTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showExpenseSegue" {
            let nextVC = segue.destination as! ExpenseDetailViewController
            nextVC.expense = sender as? Expense
        }
        
        if segue.identifier == "expenseSegue" {
            let nextVC = segue.destination as! CreateExpenseModalViewController
            nextVC.budget = budget
        }
        
        if segue.identifier == "addIncomeSegue" {
            let nextVC = segue.destination as! AddIncomeViewController
            nextVC.budget = budget
        }
        
        
    }
    
    @IBAction func unwindToWalletView(segue:UIStoryboardSegue) {
        walletTableView.reloadData()
        refreshBudgetIncomeLabel()
    }
    
    func refreshBudgetIncomeLabel() {
        let formatter = NumberFormatter()
        let income = (budget?.totalIncome)!
        formatter.numberStyle = .currency
        incomeLabel.text = formatter.string(from: income)
    }


}
