//
//  MainViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var budgets: [Budget] = []
    
    @IBOutlet weak var budgetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTableView.delegate = self
        budgetTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = budgets[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            budgets = try context.fetch(Budget.fetchRequest())
            budgetTableView.reloadData()
            
        } catch {
            print("Error fetching Budgets")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = budgets[indexPath.row]
        performSegue(withIdentifier: "walletSegue", sender: budget)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "walletSegue" {
            let nextVC = segue.destination as! WalletViewController
            nextVC.budget = sender as? Budget
        }
        
        
    }
    


}

