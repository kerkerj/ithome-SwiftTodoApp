//
//  UpdateViewController.swift
//  ithome-TODOAPP
//
//  Created by Jerry Huang on 2014/10/21.
//  Copyright (c) 2014年 kerkerj. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    var from: String!
    var delegate: UpdateTODOlistDelegate!
    
    var index: Int!
    var content: String!
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: Selector("save"))

        if self.from == "edit" {
            self.textField.text = content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func save() {
        if from == "add" {
            delegate.addData("g6", content: self.textField.text)
            self.navigationController?.popToRootViewControllerAnimated(true)
        } else if from == "edit" {
            println("Save edited data")
        }
    }
}
