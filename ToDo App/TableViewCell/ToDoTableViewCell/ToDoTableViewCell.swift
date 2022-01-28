//
//  ToDoTableViewCell.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 26/01/22.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var lblTask: UILabel!
    @IBOutlet weak var lblTaskDescription: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
