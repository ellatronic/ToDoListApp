//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Ella on 3/1/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // Instantiate an array of toDoItems
    var toDoItems = [ToDoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "Cell")

        // tap on screen outside the keyboard to dismiss the keyboard
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
    }

    // MARK: IBActions
    // if the text in itemTextField is not nil, add the new to do item to the beginning of the array, update the table view, clear the text field
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addNewItem()
    }
    

    // MARK: Helper functions
    func hideKeyboard() {
        view.endEditing(true)
    }

    func addNewItem() {
        guard let newItem = itemTextField.text else {
            return
        }
        toDoItems.insert(ToDoItem(text: newItem), at: 0)
        tableView.reloadData()
        itemTextField.text = ""
    }

    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoItemTableViewCell
        let item = toDoItems[indexPath.row]

        if (item.completed == true) {
            cell.accessoryType = .checkmark
        }
        if (item.completed == false) {
            cell.accessoryType = .none
        }


        cell.textLabel?.text = item.text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = toDoItems[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            if item.completed == false {
                cell.accessoryType = .checkmark
                item.completed = true
            }
            else {
                cell.accessoryType = .none
                item.completed = false
            }
            tableView.reloadData()
        }
    }
}

