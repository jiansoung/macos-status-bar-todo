//
//  TodoItem.swift
//  status-bar-todo
//
//  Created by songjian on 2018/9/1.
//  Copyright © 2018 Jian Soung's Studio. All rights reserved.
//

import Foundation

class TodoItem: NSObject, NSCoding {
    
    var title: String
    var completed: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = (aDecoder.decodeObject(forKey: "title") as? String) ?? ""
        self.completed = aDecoder.decodeBool(forKey: "completed")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(completed, forKey: "completed")
    }
    
}
