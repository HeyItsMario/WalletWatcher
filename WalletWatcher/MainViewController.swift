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
    let cellSpacingHeight: CGFloat = 10
    let themeColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
    
    @IBOutlet weak var budgetTableView: UITableView!
    @IBOutlet var mainIncome: UILabel!
    
    @IBOutlet weak var createWalletButton: UIButton!
    
    @IBOutlet weak var addIncomeButton: UIButton!
    @IBOutlet var mainView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mainView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 20)!]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        
        createWalletButton.layer.borderColor = themeColor.cgColor
        createWalletButton.layer.borderWidth = 1.0
        createWalletButton.setTitleColor(themeColor, for: .normal)
        
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
        budgetTableView.backgroundColor = UIColor.clear
        budgetTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        budgetController.fetchBudgets()
        budgetTableView.reloadData()
        refreshMainIncomeLabel()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = budgetController.budgets[indexPath.row].title
        cell.textLabel?.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
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

