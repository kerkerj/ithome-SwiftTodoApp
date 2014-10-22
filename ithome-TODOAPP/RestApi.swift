//
//  RestApi.swift
//  ithome-TODOAPP
//
//  Created by Jerry Huang on 2014/10/22.
//  Copyright (c) 2014年 kerkerj. All rights reserved.
//

import Foundation

class RestApi {
    var API_key = "55665566"
    var getListUrl = NSURL(string: "http://192.168.1.158:3000/user/kerkerj/todos")
    var addTodoUrl = NSURL(string: "http://192.168.1.158:3000/user/kerkerj/todos")
    
    func getTodoList(completionHandler: ((NSArray!, NSError!) -> Void)!) {
        var session = NSURLSession.sharedSession()
        
        var request = NSMutableURLRequest(URL: self.getListUrl!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.API_key, forHTTPHeaderField: "API-Key")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                return completionHandler(nil, error)
            }
            
            var error: NSError?
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSArray
            
            if (error != nil) {
                return completionHandler(nil, error)
            } else {
                return completionHandler(json, nil)
            }
        })
        
        task.resume()
    }
    
    func addTodoList(completionHandler: ((NSDictionary!, NSError!) -> Void)!, content: String) {
        var session = NSURLSession.sharedSession()
        
        var request = NSMutableURLRequest(URL: self.addTodoUrl!)
        request.HTTPMethod = "POST"
        
        var params = ["content": content] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.API_key, forHTTPHeaderField: "API-Key")
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                return completionHandler(nil, error)
            }
            
            var error: NSError?
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            
            if (error != nil) {
                return completionHandler(nil, error)
            } else {
                return completionHandler(json, nil)
            }
        })
        
        task.resume()
    }
    
    func updateTodoList(completionHandler: ((NSDictionary!, NSError!) -> Void)!, content: String, todoId: String) {
        var session = NSURLSession.sharedSession()
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.158:3000/user/kerkerj/todos/\(todoId)")!)
        request.HTTPMethod = "PUT"
        
        var params = ["content": content] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.API_key, forHTTPHeaderField: "API-Key")
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                return completionHandler(nil, error)
            }
            
            var error: NSError?
            let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            
            if (error != nil) {
                return completionHandler(nil, error)
            } else {
                return completionHandler(json, nil)
            }
        })
        
        task.resume()
    }
}