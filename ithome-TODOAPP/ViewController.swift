//
//  ViewController.swift
//  ithome-TODOAPP
//
//  Created by Jerry Huang on 2014/10/21.
//  Copyright (c) 2014年 kerkerj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fakeData = [[String:String]]()
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fakeData = [
            ["id": "1", "content": "A"],
            ["id": "2", "content": "B"],
            ["id": "3", "content": "C"],
        ]
        self.view.backgroundColor = UIColor.yellowColor()
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.view.addSubview(self.tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fakeData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier("CustomCell") as? CustomTableViewCell
        
        if cell == nil {
            var objects = NSBundle.mainBundle().loadNibNamed("CustomTableViewCell", owner: self, options: nil)
            cell = objects[0] as? CustomTableViewCell
        }
        
        cell!.textLabel?.text = (self.fakeData[indexPath.row])["content"]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var showViewController = ShowViewController(nibName: "ShowViewController", bundle: nil)
        showViewController.index = indexPath.row
        showViewController.content = fakeData[indexPath.row]["content"]
        
        // 回復非選取狀態
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationController?.pushViewController(showViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        self.fakeData.removeAtIndex(indexPath.row)
        
        dispatch_async(dispatch_get_main_queue(), {
            // must be "tableView!" not "tableView?"
            self.tableView!.reloadData()
        })

        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "Deleted!"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }

}

