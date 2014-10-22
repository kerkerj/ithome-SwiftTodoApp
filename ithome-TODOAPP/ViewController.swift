//
//  ViewController.swift
//  ithome-TODOAPP
//
//  Created by Jerry Huang on 2014/10/21.
//  Copyright (c) 2014年 kerkerj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateTODOlistDelegate {
    
    var fakeData = [[String:String]]()
    var tableView: UITableView?
    var api: RestApi = RestApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Done, target: self, action: Selector("pushToAddTODO"))
        
//        fakeData = [
//            ["id": "1", "content": "A"],
//            ["id": "2", "content": "B"],
//            ["id": "3", "content": "C"],
//        ]
        self.view.backgroundColor = UIColor.yellowColor()
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.view.addSubview(self.tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        api.getTodoList({data, error -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertView()
                    alert.title = "Yoooooooooooooooo"
                    alert.message = "Get list faild, maybe check your network: \(error)"
                    alert.addButtonWithTitle("ok")
                    alert.delegate = self
                    alert.show()
                    println(error)
                })
            }
            
            if (data != nil) {
                
                var tmpArr = [[String: String]]()
                
                for item in data {
                    var _id = item["_id"] as String
                    var content = item["content"] as String
                    var dic = [String: String]()
                    
                    dic["_id"] = _id
                    dic["content"] = content
                    
                    tmpArr.append(dic)
                }
                
                self.fakeData = tmpArr
                
                println(self.fakeData)
                
                dispatch_async(dispatch_get_main_queue(), {
                    // must be "tableView!" not "tableView?"
                    self.tableView!.reloadData()
                })
                
            }
        })
        
        dispatch_async(dispatch_get_main_queue(), {
            // must be "tableView!" not "tableView?"
            self.tableView!.reloadData()
        })
    }
    
    // MARK:- ??
    
    func pushToAddTODO(){
        var addViewController = UpdateViewController(nibName: "UpdateViewController", bundle: nil)
        addViewController.from = "add"
        addViewController.delegate = self
        
        self.navigationController?.pushViewController(addViewController, animated: true)
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
        
        cell!.textLabel.text = (self.fakeData[indexPath.row])["content"]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var showViewController = ShowViewController(nibName: "ShowViewController", bundle: nil)
        showViewController.index = indexPath.row
        showViewController.id = fakeData[indexPath.row]["_id"]
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
    
    // MARK: - Delegate
    
    func addData(id: String, content: String) {
        self.fakeData.append(["id": id, "content": content])
        
        dispatch_async(dispatch_get_main_queue(), {
            // must be "tableView!" not "tableView?"
            self.tableView!.reloadData()
        })
    }
    

}

