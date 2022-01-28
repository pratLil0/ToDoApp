//
//  ViewControllerExtension.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 29/01/22.
//

import UIKit
import Foundation
import CoreData

extension UIViewController {
    
    func showAlert(date: String) {
        
        //Variable to store alertTextField
        var taskTextField = UITextField()
        var taskDescriptionTextField = UITextField()
        
        let alert = UIAlertController(title: "Add task for \(date)", message: "", preferredStyle: .alert)
        alert.addTextField { taskTF in
            taskTF.placeholder = "Create new task"
            
            //Copy alertTextField in local variable to use in current block of code
            taskTextField = taskTF
        }
        
        alert.addTextField { taskDescriptionTF in
            taskDescriptionTF.placeholder = "Create new task description (Optional)"
            
            //Copy alertTextField in local variable to use in current block of code
            taskDescriptionTextField = taskDescriptionTF
        }
        
        let action = UIAlertAction(title: "Add task", style: .default) { action in
            //Prints the alertTextField's value
            print(taskTextField.text!)
            print(taskDescriptionTextField.text!)
            
            let toDoTask = Task(context: PersistentStorage.sharedInstance.context)
            if taskTextField.text != "" {
                toDoTask.task = taskTextField.text
                toDoTask.taskDescription = taskDescriptionTextField.text
                toDoTask.date = date
                
                PersistentStorage.sharedInstance.saveContext()
            } else {
                let alert = UIAlertController(title: "Error", message: "Please add task", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
            
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        //        return alert
    }
    
    func showAlertToUpdate(date: String, fetchedObject: Task) {
        
        //Variable to store alertTextField
        var taskTextField = UITextField()
        var taskDescriptionTextField = UITextField()
        
        let alert = UIAlertController(title: "Add task for \(date)", message: "", preferredStyle: .alert)
        alert.addTextField { taskTF in
            taskTF.placeholder = "Create new task"
            
            //Copy alertTextField in local variable to use in current block of code
            taskTextField = taskTF
        }
        
        alert.addTextField { taskDescriptionTF in
            taskDescriptionTF.placeholder = "Create new task description (Optional)"
            
            //Copy alertTextField in local variable to use in current block of code
            taskDescriptionTextField = taskDescriptionTF
        }
        
        let action = UIAlertAction(title: "Add task", style: .default) { action in
            //Prints the alertTextField's value
            print(taskTextField.text!)
            print(taskDescriptionTextField.text!)
            
            if taskTextField.text != "" {
                fetchedObject.task = taskTextField.text
                fetchedObject.taskDescription = taskDescriptionTextField.text
                fetchedObject.date = date
                
                PersistentStorage.sharedInstance.saveContext()
            } else {
                let alert = UIAlertController(title: "Error", message: "Please add task", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
            
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        //        return alert
    }
    
    static func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.rootViewController?.topMostViewController()
        }
        
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
    }
    
    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        }
        else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        }
        
        else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        
        else {
            return self
        }
    }
}
