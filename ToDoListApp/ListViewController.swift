//
//  ListViewController.swift
//  ToDoListApp
//
//  Created by Ella on 3/2/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var listTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!

    // Instantiate an array of toDoLists
    var toDoLists = [ToDoList]()
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListCell")

        // tap on screen outside the keyboard ot dismiss the keyboard
//        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGuesture)

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listTableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toItemViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            if let selectedIndexPath = selectedIndexPath {
                destination.toDoItems = toDoLists[selectedIndexPath.row].items
            }
        }
    }

}
