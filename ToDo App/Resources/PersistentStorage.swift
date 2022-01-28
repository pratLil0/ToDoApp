//
//  PersistentStorage.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 26/01/22.
//

import UIKit
import Foundation
import CoreData

final class PersistentStorage {
    
    static let sharedInstance = PersistentStorage()
    
    private init() {
        
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ToDo_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func updateData(date: String, task: String){
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "task = %@", task)
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let test = try context.fetch(fetchRequest)
   
            let objectUpdate = test[0] as NSManagedObject
            
            guard let vc = UIViewController.topMostViewController() else {
                return
            }
            
            vc.showAlertToUpdate(date: date, fetchedObject: objectUpdate as! Task)
            }
        catch
        {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
   
    }
    
    func deleteData(date: String, task: String){
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "task = %@", task)
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
            {
                let test = try context.fetch(fetchRequest)
                
                for object in test {
                    if object.task == task {
                        let objectToDelete = object as NSManagedObject
                        context.delete(objectToDelete)
                    }
                }
                
                do{
                    try context.save()
                }
                catch
                {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                
            }
        catch
        {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
