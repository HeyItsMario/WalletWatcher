//
//  BudgetController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import Foundation
import UIKit

class BudgetController {

    var totalIncome:Income?
    var budgets: [Budget] = []
    
    
    init() {
        fetchIncome()
        fetchBudgets()
    }
    
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
        print(totalIncome?.total!)
        let newIncome = (totalIncome?.total?.doubleValue)! + (amount as NSDecimalNumber).doubleValue
        let decimalIncome = Decimal(newIncome)
        totalIncome?.total! = NSDecimalNumber(decimal: decimalIncome)
        print(totalIncome?.total!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }


}
