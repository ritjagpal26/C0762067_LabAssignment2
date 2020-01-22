//
//  addDesViewController.swift
//  C0762067_LabAssignment2
//
//  Created by Mac on 2020-01-21.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import  CoreData
class addDesViewController: UIViewController {
    var taskClassVar : Task!
    var home: HomeController?
    //    var taskedi= : [Task]()
    @IBOutlet weak var numberOfDaysField: UITextField!
    @IBOutlet weak var descriptField: UITextField!
    @IBOutlet weak var taskNameField: UITextField!
    
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEdit {
            numberOfDaysField.text = "\(self.taskClassVar.numberOfdays)"
            descriptField.text  = taskClassVar.descript
            taskNameField.text = taskClassVar.task
            
        }
        //loadCoreData()
        // NotificationCenter.default.addObserver(self, selector: #selector(saveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func addTaskButton(_ sender: Any) {
        if isEdit{
    let   appdelegate = UIApplication.shared.delegate as! AppDelegate;
    let managedContext = appdelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
   //  fetchRequest.predicate = NSPredicate(format: "Tasks=%@", "\(taskClassVar.task)")
//            fetchRequest.returnsObjectsAsFaults = false

    do
    {
        let results = try  managedContext.fetch(fetchRequest)
       

        
            for result in results as! [NSManagedObject] {
               

                   
                managedContext.delete(result)
            
                }

            
            do {
         try  managedContext.save()
            }catch{
         print(error)
      }
        }
    catch{
            print(error)}
        
            
        
      
        
            let fetchRequest1 = NSFetchRequest<NSManagedObject>(entityName: "Tasks")

            do
            {
                let results = try  managedContext.fetch(fetchRequest1)
               

                if results.count > 0{
                    
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "task") as? String{
                            if name != taskClassVar.task {

                           
                                let task = taskNameField.text
                        let date = taskClassVar.datetime
                                let numberofDays = Int16(numberOfDaysField.text ?? "0") ?? 0
                                let des = descriptField.text
                        result.setValue(task, forKey: "task")
                        result.setValue(date, forKey: "datetime")
                        result.setValue(numberofDays, forKey: "numberOfdays")
                        result.setValue(des, forKey: "descript")
                    }
                        }

                    }
                    do {
                        
                 try  managedContext.save()
                        home?.taskTableView.reloadData()
                        
                    }
                    catch{
                 print(error)
              }
                }
            }catch{
                    print(error)}
    }
                
        else {
           
            let task = self.taskNameField.text ?? ""
            let date = "21-01-2020 "
            let numberofDays = Int16(self.numberOfDaysField.text ?? "0") ?? 0
            let des = self.descriptField.text ?? ""
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // second step is contex
        let managedContex = appDelegate.persistentContainer.viewContext
        
        
        let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: managedContex)
        taskEntity.setValue(task, forKey: "task")
        taskEntity.setValue(numberofDays, forKey: "numberOfdays")
        taskEntity.setValue(des, forKey: "descript")
        taskEntity.setValue(date, forKey: "datetime")
        do
        {
            try managedContex.save()
            self.home?.taskTableView.reloadData()
        }
        catch {
            print(error)
            
           
            }
        }

    
   
        
        
        
        //let taskvar = Task(datetime: date , task: task, numberOfdays: numberofDays, descript: des)
        
         
        //  saveCoreData()
        if let home = home {
            home.taskTableView.reloadData()
        }
        
        //  let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //  let vc = storyboard.instantiateViewController(withIdentifier: "newVc") as! ViewController
        
        navigationController?.popViewController(animated: true)
        home?.taskTableView.reloadData()
        
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if let tasktable = segue.destination as? ViewController{
    //        tasktable.taskClassVar = self.taskClassVar
    //    }
    //    }
    //    @objc func   savedata() {
    //        let filedpath = getFieldPath()
    //        var saveString = ""
    //        for task in taskClassVar{
    //            saveString = "\(saveString)\(task.task),\(task.datetime),\(task.numberOfdays),\(task.descript)\n"
    //        }
    //        do {
    //            try saveString.write(toFile: filedpath, atomically: true, encoding: .utf8)
    //        }catch{
    //            print(error)
    //        }
    //    }
    @objc func saveCoreData() {
        //    clearCoreData()
        // create an instance of appdelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // second step is contex
        let managedContex = appDelegate.persistentContainer.viewContext
        
        
        let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: managedContex)
        taskEntity.setValue(taskClassVar?.task, forKey: "task")
        taskEntity.setValue(taskClassVar?.numberOfdays, forKey: "numberOfdays")
        taskEntity.setValue(taskClassVar?.descript, forKey: "descript")
        taskEntity.setValue(taskClassVar?.datetime, forKey: "datetime")
        do
        {
            try managedContex.save()
        }
        catch {
            print(error)
        }
        
        
    }
}
func loadCoreData(){
    var taskClassVar = [Task]()
    
    // create an instance of appdelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // second step is contex
    let managedContex = appDelegate.persistentContainer.viewContext
    
    let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Tasks")
    do {
        let results = try managedContex.fetch(fetchrequest)
        if results is [NSManagedObject]{
            for result in results as! [NSManagedObject]{
                let task = result.value(forKey: "task") as! String
                let datetime = result.value(forKey: "datetime") as! String
                let numberOfDays = result.value(forKey: "numberOfdays") as! Int16
                let Des = result.value(forKey: "descript") as! String
                
                taskClassVar.append(Task(datetime: datetime, task: task, numberOfdays: numberOfDays, descript: Des))
            }
        }
    }catch {
        print(error)
    }
    
    
    
}
func clearCoreData(){
    // create an instance of appdelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // second step is contex
    let managedContex = appDelegate.persistentContainer.viewContext
    
    let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Tasks")
    fetchrequest.returnsObjectsAsFaults = false
    do {
        let results = try managedContex.fetch(fetchrequest)
        for manageobject in results{
            if  let manageobjectdata = manageobject as? NSManagedObject{
                managedContex.delete(manageobjectdata)
            }
            
        }
        
    }catch{
        print(error)
    }

}




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



