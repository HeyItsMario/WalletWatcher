//
//  CreateExpenseModalViewController.swift
//  WalletWatcher
//
//  Created by Mario Cordova on 6/18/17.
//  Copyright © 2017 Mario Cordova. All rights reserved.
//

import UIKit

class CreateExpenseModalViewController: UIViewController {

    @IBOutlet var incomeField: UITextField!
    @IBOutlet var titleField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func enterTapped(_ sender: Any) {
//        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let game = Game(context: context)
//            game.title = titleField.text

        
    }

    @IBAction func cancelTapped(_ sender: Any) {
    }
    
}
