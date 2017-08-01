//
//  MainViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var budgetController = BudgetController.sharedInstance
    
    @IBOutlet weak var budgetTableView: UITableView!
    @IBOutlet var mainIncome: UILabel!
    
    @IBOutlet weak var createWalletButton: UIButton!
    
    @IBOutlet weak var addIncomeButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 20)!]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let borderColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
        
        addIncomeButton.layer.borderColor = borderColor.cgColor
        addIncomeButton.layer.borderWidth = 1.0
        addIncomeButton.setTitleColor(borderColor, for: .normal)
        
        createWalletButton.layer.borderColor = borderColor.cgColor
        createWalletButton.layer.borderWidth = 1.0
        createWalletButton.setTitleColor(borderColor, for: .normal)
        
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        budgetController.fetchBudgets()
        budgetTableView.reloadData()
        refreshMainIncomeLabel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = budgetController.budgets[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetController.budgets.count
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
            nextVC.fromSegue = "mainIncome"

        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            budgetController.deleteBudget(budget: budgetController.budgets[indexPath.row])
            budgetTableView.reloadData()
            refreshMainIncomeLabel()
        }
    }
    
    @IBAction func unwindToMainViewFromBudgetSegue(segue:UIStoryboardSegue) {
        budgetController.fetchBudgets()
        budgetTableView.reloadData()
        refreshMainIncomeLabel()
    }
    
    @IBAction func unwindToMainViewSegue(segue:UIStoryboardSegue) {
        refreshMainIncomeLabel()
    }
    
    func refreshMainIncomeLabel() {
        let formatter = NumberFormatter()
        let income = (budgetController.totalIncome?.total)!
        formatter.numberStyle = .currency
        mainIncome.text = formatter.string(from: income)
    }



}

