////
////  ToDoTaskViewModel.swift
////  ToDo App
////
////  Created by Pratyush Srivastava on 28/01/22.
////
//
//import Foundation
//import CoreData
//
//class ToDoTaskViewModel {
//
//    public func fetchTask(onSuccess : @escaping(_ response : [ToDoTask])-> Void, onFailure: @escaping(_ response : ErrorModel)-> Void) {
//
//        do {
////            guard let taskResult = try PersistentStorage.sharedInstance.context.fetch(Task.fetchRequest()) as? [Task] else { return }
//            let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
//            let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
//            fetchRequest.sortDescriptors = [sortDescriptor]
//            fetchRequest.resultType = .managedObjectResultType
//            fetchRequest.returnsObjectsAsFaults = false
//            let fetchedResults = try PersistentStorage.sharedInstance.context.fetch(fetchRequest)
//            var jsonDict = [String: Any]()
//            var dataArr = [Any]()
//            for data in fetchedResults {
//                var toDoTask = ToDoTask()
//                toDoTask.task = data.task!
//                toDoTask.taskDescription = data.taskDescription!
//                toDoTask.date = data.date!
//                dataArr.append(toDoTask)
//            }
//            jsonDict["task"] = dataArr
//            let json = json(from: jsonDict.description)
//            let result = self.parseResponse(json, ToDoTask())
//            onSuccess(result as! [ToDoTask])
//        } catch let error {
//            debugPrint(error)
//        }
//    }
//
//    func parseResponse(_ response:String?, _ responseModel:Decodable) -> Decodable {
//        var result = responseModel
//
//        let decoder = JSONDecoder()
//        do {
//            result = try decoder.decode([ToDoTask].self, from: (response?.data(using: .utf8))!)
//            print(result)
//        } catch let error {
//            print("decoding error: \(error)")
//        }
//        return result
//    }
//
//    func json(from object:Any) -> String? {
//        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//            return nil
//        }
//        return String(data: data, encoding: String.Encoding.utf8)
//    }
//}
