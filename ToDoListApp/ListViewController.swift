//
//  ListViewController.swift
//  ToDoListApp
//
//  Created by Ella on 3/2/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var listTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!

    // Instantiate an array of toDoLists
    var toDoLists = [ToDoList]()
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")
        self.listTextField.delegate = self

        // tap on screen outside the keyboard ot dismiss the keyboard
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGuesture)
        tapGuesture.cancelsTouchesInView = false

        if toDoLists.count < 0 {
            return
        }
        toDoLists.append(ToDoList(text: "personal list"))
    }

    // MARK: IBActions
    @IBAction func addListButton(_ sender: UIButton) {
        addNewList()
    }

    // MARK: Helper functions
    func hideKeyboard() {
        view.endEditing(true)
    }

    func addNewList() {
        guard let newList = listTextField.text else {
            return
        }
        toDoLists.insert(ToDoList(text: newList), at: 0)
        listTableView.reloadData()
        listTextField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNewList()
        return true
    }

    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        let list = toDoLists[indexPath.row]

        cell.textLabel?.text = list.text
        return cell
    }

    // Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listTableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toItemViewController", sender: self)
        listTextField.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            if let selectedIndexPath = selectedIndexPath {
                destination.toDoItems = toDoLists[selectedIndexPath.row].items
            }
        }
    }

    // Swipe to delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            toDoLists.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}
