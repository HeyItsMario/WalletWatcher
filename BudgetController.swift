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
    
    func addIncome(amount: NSDecimalNumber) {
        totalIncome?.total = totalIncome?.total?.adding(amount)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        printIncome()
    }
    
    func addBudgetIncome(amount: NSDecimalNumber, budget: Budget) {
        let wallet: Budget?
        
        if let i = budgets.index(where: {$0 == budget}) {
            wallet = budgets[i]
            wallet?.totalIncome = wallet?.totalIncome?.adding(amount)
        }
        
        addIncome(amount: amount)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func addExpense(amount: NSDecimalNumber, store: String, description: String, budget: Budget) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let expense = Expense(context: context)
        let date = Date()
        
        expense.cost = amount as NSDecimalNumber
        expense.store = store
        expense.desc = description
        expense.date = date as NSDate
        
        if let i = budgets.index(where: { $0 == budget }) {
            budgets[i].addToExpenses(expense)
            budgets[i].totalIncome = budgets[i].totalIncome?.subtracting(amount)
            totalIncome?.total = totalIncome?.total?.subtracting(amount)
        } else {
            print("Error cannot find Budget in the Budget array")
        }
       
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    }
    
    func deleteExpense(budget: Budget, expense: Expense) {
        budget.removeFromExpenses(expense)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let amountToAddBack = expense.cost! as NSDecimalNumber
        addBudgetIncome(amount: amountToAddBack, budget: budget)
        fetchBudgets()
    }
    
    func deleteBudget(budget: Budget) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(budget)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let amountToSubtract = budget.totalIncome?.multiplying(by: -1)
        addIncome(amount: amountToSubtract!)
        fetchBudgets()
    }
    
    func createBudget(title: String, amount: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let budget = Budget(context: context)
        budget.title = title
        budget.totalIncome = NSDecimalNumber(string: amount)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        addIncome(amount: (budget.totalIncome)!)
        printIncome()
    }
    
    private func printIncome() {
        print("Total income: \(totalIncome!.total!.decimalValue)")
    }
    

}
