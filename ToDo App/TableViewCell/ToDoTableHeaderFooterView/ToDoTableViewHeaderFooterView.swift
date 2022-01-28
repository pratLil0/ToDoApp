//
//  ToDoTableViewHeaderFooterView.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 26/01/22.
//

import UIKit

protocol ToDoTableViewHeaderFooterViewProtocol {
    func addTaskTapped(headerFooterView: UITableViewHeaderFooterView)
}

class ToDoTableViewHeaderFooterView: UITableViewHeaderFooterView {

    //MARK: Properties
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var btnAddTask: UIButton!
    
    var delegate: ToDoTableViewHeaderFooterViewProtocol?
    
    override func awakeFromNib() {
        
    }
    
    //MARK: Action
    @IBAction func btnAddTaskTapped(_ sender: Any) {
        
        delegate?.addTaskTapped(headerFooterView: self)
    }
    
}
