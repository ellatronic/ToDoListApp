//
//  ListTableViewCell.swift
//  ToDoListApp
//
//  Created by Ella on 3/2/17.
//  Copyright © 2017 Ellatronic. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    var toDoList: ToDoList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
