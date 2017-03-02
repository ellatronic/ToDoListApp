//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Ella on 3/1/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    // Text description of item
    var text: String

    // Completion state of item: completed or not
    var completed: Bool

    // Initialize ToDoItem with default values
    init(text: String) {
        self.text = text
        self.completed = false
    }

}
