//
//  BudgetController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import Foundation
import UIKit

final class BudgetController {

    var totalIncome:Income?
    var budgets: [Budget] = []
    
    
    private init() {
        fetchIncome()
        fetchBudgets()
    }
    
    static let sharedInstance = BudgetController()
    
    
    func fetchIncome() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            if try (context.fetch(Income.fetchRequest())).count == 0 {
                print("No Income stored yet. Preparing to store...")
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let income = Income(context: context)
                income.total = Decimal(string: "0.00") as NSDecimalNumber?
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            totalIncome = try (context.fetch(Income.fetchRequest()))[0]
        } catch {
            print("Error fetching Income")
        }
    }
    
    func fetchBudgets() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            budgets = try context.fetch(Budget.fetchRequest())
            
        } catch {
            print("Error fetching Budgets")
        }
    }
    
    func addIncome(amount: Decimal) {
        let newIncome = (totalIncome?.total?.doubleValue)! + (amount as NSDecimalNumber).doubleValue
        let decimalIncome = Decimal(newIncome)
        totalIncome?.total! = NSDecimalNumber(decimal: decimalIncome)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addBudgetIncome(amount: Decimal, budget: Budget) {
        let wallet: Budget?
        let newIncome: Double
        let decimalIncome: Decimal
        
        if let i = budgets.index(where: {$0 == budget}) {
            wallet = budgets[i]
            newIncome = (wallet?.totalIncome?.doubleValue)! + (amount as NSDecimalNumber).doubleValue
            decimalIncome = Decimal(newIncome)
            wallet?.totalIncome = NSDecimalNumber(decimal: decimalIncome)
            print("New budget income: \((wallet?.totalIncome)!)")
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func addExpense(amount: Decimal, store: String, description: String, budget: Budget) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let expense = Expense(context: context)
        expense.cost = amount as NSDecimalNumber
        expense.store = store
        expense.desc = description
        
        if let i = budgets.index(where: { $0 == budget }) {
            budgets[i].addToExpenses(expense)
        } else {
            print("Error cannot find Budget in the Budget array")
        }
       
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    }


}
