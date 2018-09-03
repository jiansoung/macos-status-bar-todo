//
//  AddTodoViewController.swift
//  status-bar-todo
//
//  Created by songjian on 2018/9/1.
//  Copyright © 2018 Jian Soung's Studio. All rights reserved.
//

import Cocoa

protocol AddTodoViewControllerDelegate: AnyObject {
    func addTodoViewController(_ controller: AddTodoViewController, didAddTodoWith title: String)
    func addTodoViewControllerDidCancel(_ controller: AddTodoViewController)
}

class AddTodoViewController: NSViewController {

    weak var delegate: AddTodoViewControllerDelegate?

}

extension AddTodoViewController: NSControlTextEditingDelegate {
    
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        let string = fieldEditor.string
        delegate?.addTodoViewController(self, didAddTodoWith: string)
        return true
    }
    
    override func cancelOperation(_ sender: Any?) {
        delegate?.addTodoViewControllerDidCancel(self)
    }
    
}
