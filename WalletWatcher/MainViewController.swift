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
        
        mainView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 28/255, green: 141/255, blue: 220/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 20)!]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        
        createWalletButton.layer.borderColor = themeColor.cgColor
        createWalletButton.layer.borderWidth = 1.0
        createWalletButton.setTitleColor(themeColor, for: .normal)
        
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
        budgetTableView.layer.masksToBounds = false
        budgetTableView.backgroundColor = UIColor.clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        budgetController.fetchBudgets()
        budgetTableView.reloadData()
        refreshMainIncomeLabel()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return budgetController.budgets.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = budgetController.budgets[indexPath.section].title
        cell.layer.cornerRadius = 5.0
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.9
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //budgetController.budgets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = budgetController.budgets[indexPath.section]
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
            budgetController.deleteBudget(budget: budgetController.budgets[indexPath.section])
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

