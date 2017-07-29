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
    
    private func addTwoNumbers(valueOne: NSDecimalNumber, valueTwo: Decimal ) -> NSDecimalNumber {
        return valueOne.adding(valueTwo as NSDecimalNumber)
    }
    
    private func subTwoNumbers(valueOne: NSDecimalNumber, valueTwo: Decimal ) -> NSDecimalNumber {
        return valueOne.subtracting(valueTwo as NSDecimalNumber)
    }
    
    func addIncome(amount: Decimal) {
        let newIncome = addTwoNumbers(valueOne: (totalIncome?.total)!, valueTwo: amount)
        totalIncome?.total! = newIncome
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addBudgetIncome(amount: Decimal, budget: Budget) {
        let wallet: Budget?
        let newIncome: NSDecimalNumber
        
        if let i = budgets.index(where: {$0 == budget}) {
            wallet = budgets[i]
            newIncome = addTwoNumbers(valueOne: (wallet?.totalIncome)!, valueTwo: amount)
            wallet?.totalIncome = newIncome
        }
        
        addIncome(amount: amount)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func addExpense(amount: Decimal, store: String, description: String, budget: Budget) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let expense = Expense(context: context)
        let date = Date()
        
        expense.cost = amount as NSDecimalNumber
        expense.store = store
        expense.desc = description
        expense.date = date as NSDate
        
        if let i = budgets.index(where: { $0 == budget }) {
            budgets[i].addToExpenses(expense)
            budgets[i].totalIncome = NSDecimalNumber( value: (budgets[i].totalIncome?.doubleValue)! - (amount as NSDecimalNumber).doubleValue )
            totalIncome?.total = NSDecimalNumber( value: (totalIncome?.total?.doubleValue)! - (amount as NSDecimalNumber).doubleValue )
        } else {
            print("Error cannot find Budget in the Budget array")
        }
       
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    }
    
    func deleteExpense(budget: Budget, expense: Expense) {
        budget.removeFromExpenses(expense)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let amountToAddBack = expense.cost! as Decimal
        addBudgetIncome(amount: amountToAddBack, budget: budget)
        fetchBudgets()
    }
    
    func deleteBudget(budget: Budget) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(budget)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        fetchBudgets()
    }
    

}
