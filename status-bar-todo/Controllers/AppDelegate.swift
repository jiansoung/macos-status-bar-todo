//
//  AppDelegate.swift
//  status-bar-todo
//
//  Created by songjian on 2018/9/1.
//  Copyright © 2018 Jian Soung's Studio. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength
    )
    lazy var todoItemsHelper = TodoItemsHelper()
    lazy var editTodosWindowController = EditTodosWindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        editTodosWindowController.delegate = self
        editTodosWindowController.todoItemsHelper = todoItemsHelper
        updateStatusItem()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    // MARK: - Validate Menu Item
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if let todoItem = menuItem.representedObject as? TodoItem {
            menuItem.state = todoItem.completed ? .on : .off
            guard let isVisible = editTodosWindowController.window?.isVisible else { return true }
            return !isVisible
        }
        return true
    }

    
    // MARK: - Setup Status Item
    
    private func updateStatusItem() {
        updateStatusItemButton()
        updateStatusItemMenu()
    }
    
    private func updateStatusItemButton() {
        guard let button = statusItem.button else { return }
        let totalCount = todoItemsHelper.todoItems.count
        let completedCount = todoItemsHelper.todoItems.filter { $0.completed }.count
        button.title = "☑️\(completedCount)/\(totalCount)"
    }
    
    private func updateStatusItemMenu() {
        let menu = NSMenu()
        menuItems(todoItems: todoItemsHelper.todoItems).forEach(menu.addItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(editMenuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(quitMenuItem)
        statusItem.menu = menu
    }
    
    private func menuItems(todoItems: [TodoItem]) -> [NSMenuItem] {
        var menuItems = [NSMenuItem]()
        todoItems.forEach { todoItem in
            let menuItem = NSMenuItem(
                title: todoItem.title,
                action: #selector(menuTodoItemPressed(_:)),
                keyEquivalent: ""
            )
            menuItem.representedObject = todoItem
            if todoItem.completed {
                let attributes: [NSAttributedStringKey : Any] = [
                    .strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
                    .font: NSFont.menuFont(ofSize: 0)
                ]
                let attributedString = NSAttributedString(
                    string: todoItem.title,
                    attributes: attributes
                )
                menuItem.attributedTitle = attributedString
            }
            menuItems.append(menuItem)
        }
        return menuItems
    }
    
    private var editMenuItem: NSMenuItem {
        return NSMenuItem(
            title: "Edit TODOS...",
            action: #selector(menuEditItemPressed(_:)),
            keyEquivalent: ""
        )
    }
    
    private var quitMenuItem: NSMenuItem {
        return NSMenuItem(
            title: "Quit",
            action: #selector(NSApp.terminate(_:)),
            keyEquivalent: "q"
        )
    }
    
    
    // MARK: - Menu Actions
    
    @objc private func menuTodoItemPressed(_ sender: NSMenuItem) {
        guard let todoItem = sender.representedObject as? TodoItem else { return }
        todoItemsHelper.mark(todoItem: todoItem, completed: !todoItem.completed)
        updateStatusItem()
    }
    
    @objc private func menuEditItemPressed(_ sender: NSMenuItem) {
        NSApp.activate(ignoringOtherApps: true)
        editTodosWindowController.showWindow(sender)
    }
    
}


extension AppDelegate: EditTodosWindowControllerDelegate {
    
    func editTodosWindowControllerDidUpdateTodoItems(_ controller: EditTodosWindowController) {
        updateStatusItem()
    }
    
}
