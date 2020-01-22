//
//  ViewController.swift
//  C0762067_LabAssignment2
//
//  Created by Mac on 2020-01-20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var taskClassVar = [Task]()
  var find = false
   
    let managedContex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [NSManagedObject]?

    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCoreData()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        
    
        // Do any additional setup after loading the view.
    }
    @IBAction func sortTasksButton(_ sender: Any) {
           let sorttable = UIAlertController(title: "Sort Table", message: "Please Select one option", preferredStyle: .alert)
           sorttable.addAction(UIAlertAction(title: "By Date", style: .default, handler: {
                       action in
                      self.taskClassVar.sort(by: {$0.datetime < $1.datetime} )
                    self.taskTableView.reloadData()
                                 
                             }))
                                  
           sorttable.addAction(UIAlertAction(title: "By Task Name", style: .default, handler: {
               action in
              
               self.taskClassVar.sort(by:  {$0.task.lowercased() < $1.task.lowercased()} )
            
            self.taskTableView.reloadData()
               
           }))
      
                            
                                 self.present(sorttable, animated: true)
       }
       
    override func viewWillAppear(_ animated: Bool) {
        taskTableView.reloadData()
        self.loadCoreData()

    }
    @IBOutlet weak var searchbar: UISearchBar!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
   
        }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func loadCoreData(){
        taskClassVar = [Task]()

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
                
                taskTableView.reloadData()
            }
        }catch {
            print(error)
        }

        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskClassVar.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let taskVar = taskClassVar![indexPath.row]
        let task = taskClassVar[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskcell" , for: indexPath) as! TaskTableViewCell
        cell.taskLAble.text = task.task
        cell.datelable.text =   task.datetime
        cell.numberdaysLabel.text = String(task.numberOfdays)
        
        return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "see") as! addDesViewController
        vc.taskClassVar = taskClassVar[indexPath.row]
        vc.home = self
        vc.isEdit = true
        
        
                  
                  navigationController?.pushViewController(vc,animated: true)
    }
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
             let DeleteAction = UIContextualAction(
                        style: .normal,
                        title: "Remove Task",
                        handler: { (action, view, completion) in

                         let   appdelegate = UIApplication.shared.delegate as! AppDelegate;
                         let managedContext = appdelegate.persistentContainer.viewContext
                         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
                         
                         do
                          {
                              let fetchedRequest = try managedContext.fetch(fetchRequest)
                              let result = fetchedRequest as! [Tasks]
                            managedContext.delete(result[indexPath.row])
                              do
                              {
                                 try managedContext.save()
                              }
                              catch
                              {
                                  print(error)
                              }
                             self.taskClassVar.remove(at: indexPath.row)
                             tableView.deleteRows(at: [indexPath], with: .fade)
                             tableView.reloadData()
                              
                          }
                          catch
                          {
                              print(error)
                          }
                         
                        
                    })

                 
                    DeleteAction.backgroundColor = .red
           
        let addDay = UIContextualAction(style: .normal , title: "Add a Day") { (action, view, error) in
            let   appdelegate = UIApplication.shared.delegate as! AppDelegate;
            let managedContext = appdelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
            
            do
            {
                let fetchedRequest = try managedContext.fetch(fetchRequest)
                let results = fetchedRequest as! [Tasks]
                let result = results[indexPath.row]
                let day = result.value(forKey: "numberOfdays") as! Int16
                result.setValue(day+1, forKey: "numberOfdays")
                do
                {
                    try self.managedContex.save()
                }
                catch{
                    print(error)
                }
                let taskdaysAdd = self.taskClassVar[indexPath.row]
                taskdaysAdd.numberOfdays += 1
                tableView.reloadData()
            }catch{
                print(error)
            }
            
            
        }
//           addDay.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
           return UISwipeActionsConfiguration(actions: [DeleteAction, addDay])
       }

        
        
        
    @IBAction func addbutton(_ sender: Any) {
        
//        self.alertAddTask()

        
    }
  /* private func alertAddTask() {
        //1. Create the alert controller.
               let taskalert = UIAlertController(title: "Add Task", message:" Add a New Task" , preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        taskalert.addTextField { (addtask) in
            addtask.text = ""
            addtask.placeholder = "Whats Your Task:"
        }
         taskalert.addTextField { (adddays) in
                    adddays.text = ""
                    adddays.placeholder = "Add number of days to accomplish the task:"
                }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        let addtask = UIAlertAction(title: "Add", style: .default, handler:{ ACTION in
            let taskField = taskalert.textFields![0] // Force unwrapping because we know it exists.
            let daysField = taskalert.textFields![1]

            let newtask = taskField.text
            let day = daysField.text
            tasks.append(newtask!)
            days.append(Int(day!) ?? 0)
            
            self.taskTableView.reloadData()
        })
    
            let cancle = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        taskalert.addAction(addtask)
        taskalert.addAction(cancle)

            
            
        self.present(taskalert, animated: true, completion: nil)
    }
    
    */
    

}

