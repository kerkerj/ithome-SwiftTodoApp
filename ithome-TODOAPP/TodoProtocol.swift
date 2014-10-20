//
//  TodoProtocol.swift
//  ithome-TODOAPP
//
//  Created by Jerry Huang on 2014/10/21.
//  Copyright (c) 2014年 kerkerj. All rights reserved.
//

import Foundation

protocol UpdateTODOlistDelegate {
    func addData(id: String, content: String)
}