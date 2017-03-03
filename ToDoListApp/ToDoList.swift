//
//  ToDoList.swift
//  ToDoListApp
//
//  Created by Ella on 3/2/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ToDoList: NSObject {
    // Text description of the list
    var text: String

    // ToDoItems in the list
    var items: [ToDoItem]

    // Initialize ToDoList with default values
    init(text: String) {
        self.text = text
        self.items = [ToDoItem(text: "Walk the dog")]
    }
}
