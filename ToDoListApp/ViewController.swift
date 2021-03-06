//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Ella on 3/1/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // Instantiate an array of toDoItems
    var toDoItems = [ToDoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemTextField.delegate = self
        tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "Cell")

        // tap on screen outside the keyboard to dismiss the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewItem()
        return true
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

    // Toggle checkmarks
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
        itemTextField.resignFirstResponder()
    }

    // Swipe to delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            toDoItems.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

