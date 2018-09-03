//
//  TodoItemTableCellView.swift
//  status-bar-todo
//
//  Created by songjian on 2018/9/1.
//  Copyright © 2018 Jian Soung's Studio. All rights reserved.
//

import Cocoa

class TodoItemTableCellView: NSTableCellView {

    var todoItem: TodoItem?
    
    // return a context-sensitive pop-up menu for a given mouse-down event.
    override func menu(for event: NSEvent) -> NSMenu? {
        let menuItem = NSMenuItem(
            title: "Delete",
            action: #selector(EditTodosWindowController.deleteMenuItemPressed(_:)),
            keyEquivalent: ""
        )
        menuItem.representedObject = todoItem
        let menu = NSMenu()
        menu.addItem(menuItem)
        return menu
    }
        
}
