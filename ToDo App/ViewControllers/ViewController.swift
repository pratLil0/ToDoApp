//
//  ViewController.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 26/01/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    //var toDoTaskVideModel = ToDoTaskViewModel()
    var todayArr: [ToDoTask] = []
    var tomorrowArr: [ToDoTask] = []
    var upcomingArr: [ToDoTask] = []
    
    var allTask: [[ToDoTask]] = []
    
    var edit: Bool = false
    
    //MARK: View Controller LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib.init(nibName: "ToDoTableViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ToDoTableViewHeaderFooterView")
        
        self.tableView.register(UINib.init(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
        
        fetchTask()
    }

    //MARK: Methods
    func fetchTask() {

        do {
            let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let fetchedResults = try PersistentStorage.sharedInstance.context.fetch(fetchRequest)
            for data in fetchedResults {
                var toDoTask = ToDoTask()
                toDoTask.task = data.task
                toDoTask.taskDescription = data.taskDescription
                toDoTask.date = data.date
                if data.date == Date().toString(dateFormat: "dd-MM-yyyy") {
                    todayArr.append(toDoTask)
                } else if data.date == Calendar.current.date(byAdding: .day, value: 1, to: Date())!.toString(dateFormat: "dd-MM-yyyy") {
                    tomorrowArr.append(toDoTask)
                } else {
                    upcomingArr.append(toDoTask)
                }
            }

//            if let todayArrData = self.todayArr, let tomArrData = self.tomorrowArr, let upcomArrData = self.upcomingArr {
//                self.allTask?.append(todayArrData)
//                self.allTask?.append(tomArrData)
//                self.allTask?.append(upcomArrData)
//            } else {
            self.allTask.append(self.todayArr)
            self.allTask.append(self.tomorrowArr)
            self.allTask.append(self.upcomingArr)
            //}
        } catch let error {
            debugPrint(error)
        }
//        toDoTaskVideModel.fetchTask(onSuccess: { (response) in
//            print(response)
//
//            for data in response {
//                if data.date == Date().toString(dateFormat: "dd-MM-yyyy") {
//                    self.todayArr.append(data)
//                } else if data.date == Calendar.current.date(byAdding: .day, value: 1, to: Date())!.toString(dateFormat: "dd-MM-yyyy") {
//                    self.tomorrowArr.append(data)
//                } else {
//                    self.upcomingArr.append(data)
//                }
//            }
//
////            if let todayArrData = self.todayArr, let tomArrData = self.tomorrowArr, let upcomArrData = self.upcomingArr {
////                self.allTask.append(todayArrData)
////                self.allTask.append(tomArrData)
////                self.allTask.append(upcomArrData)
////            } else {
//                self.allTask.append(self.todayArr)
//                self.allTask.append(self.tomorrowArr)
//                self.allTask.append(self.upcomingArr)
////            }
//        }, onFailure: { (error) in
//            print(error)
//        })
    }
}

//MARK: TableView Delegates & DataSources
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return allTask.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTask[section].isEmpty {
            return 1
        } else {
            return allTask[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! ToDoTableViewCell
        
        if !allTask[indexPath.section].isEmpty {
            let taskData = allTask[indexPath.section]
            
            cell.lblTask.text = taskData[indexPath.row].task
            cell.lblTaskDescription.text = taskData[indexPath.row].task
        } else {
            cell.lblTask.isHidden = true
            cell.lblTaskDescription.isHidden = true
            cell.separatorView.isHidden = true
            let lblNoTask = UILabel()
            lblNoTask.frame = CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height)
            lblNoTask.text = "No Task added for this section."
            lblNoTask.textAlignment = NSTextAlignment.center
            cell.contentView.addSubview(lblNoTask)
        }
        
        if indexPath.row == allTask[indexPath.section].count - 1 {
            cell.separatorView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "ToDoTableViewHeaderFooterView") as! ToDoTableViewHeaderFooterView
        header.delegate = self
        header.tag = section
        
        if section == 0 {
            header.lblDay.text = "Today"
        } else if section == 1 {
            header.lblDay.text = "Tomorrow"
        } else {
            header.lblDay.text = "Upcoming"
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.deleteData(at: indexPath)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            self.editData(at: indexPath)
        }
        editAction.backgroundColor = .purple
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func deleteData(at indexPath: IndexPath) {
        print(indexPath.row)
        let toDoSection = allTask[indexPath.section]
        
        let toDoTask = toDoSection[indexPath.row]
        
        PersistentStorage.sharedInstance.deleteData(date: toDoTask.date!, task: toDoTask.task!)
        
        tableView.beginUpdates()
        
        tableView.setEditing(false, animated: false)
        
        tableView.endUpdates()
    }
    
    func editData(at indexPath: IndexPath) {
        print(indexPath.row)
        let toDoSection = allTask[indexPath.section]
        
        let toDoTask = toDoSection[indexPath.row]
        
        PersistentStorage.sharedInstance.updateData(date: toDoTask.date!, task: toDoTask.task!)
        
        tableView.beginUpdates()
        
        tableView.setEditing(false, animated: false)
        
        tableView.endUpdates()
    }
}

extension ViewController: ToDoTableViewHeaderFooterViewProtocol {
    
    func addTaskTapped(headerFooterView: UITableViewHeaderFooterView) {
        
        let date: String
        if headerFooterView.tag == 0 {
            date = Date().toString(dateFormat: "dd-MM-yyyy")
        } else if headerFooterView.tag == 1 {
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            date = tomorrow.toString(dateFormat: "dd-MM-yyyy")
        } else {
            let upcomingDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
            date = upcomingDate.toString(dateFormat: "dd-MM-yyyy")
        }
        
        showAlert(date: date)
    }
    
}
