//
//  ShowViewController.swift
//  ithome-TODOAPP
//
//  Created by Jerry Huang on 2014/10/21.
//  Copyright (c) 2014年 kerkerj. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    var index: Int!
    var id: String!
    var content: String!
    
    @IBOutlet var indexLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexLabel.text = "\(index)"
        contentLabel.text = content
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("editTodo"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func editTodo() {
        var editViewContronller = UpdateViewController(nibName: "UpdateViewController", bundle: nil)
        editViewContronller.from = "edit"
        editViewContronller.content = content
        editViewContronller.index = index
        
        self.navigationController?.pushViewController(editViewContronller, animated: true)
    }
}
