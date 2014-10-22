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
    var api = RestApi()
    
    var index: Int!
    var content: String!
    var id: String!
    
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
            api.addTodoList({data, error -> Void in
                if data == nil {
                    println(error)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    println("done")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                })
            }, content: self.textField.text)

        } else if from == "edit" {
            println("Save edited data")
            api.updateTodoList({data, error -> Void in
                if data == nil {
                    println(error)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    println("done")
                    self.navigationController!.popToRootViewControllerAnimated(true)
                })
                
            }, content: self.textField.text, todoId: self.id)
        }
    }
}
