//
//  ViewController.swift
//  C0762067_LabAssignment2
//
//  Created by Mac on 2020-01-20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tasks : [String]!
    var date = Date()
    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        
    tasks = ["Gym", "Book Read"]
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskcell" , for: indexPath) as! TaskTableViewCell
        cell.taskLAble.text = tasks[indexPath.row]
//        cell.datelable.text =  String(date)
        
        return cell
       }
    
    @IBAction func addbutton(_ sender: Any) {
        
        let taskalert = UIAlertController(title: "Add Task", message:" Add a New Task" , preferredStyle: .alert)
        
        taskalert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input Your task.."
        })
        
        let addtask = UIAlertAction(title: "Add", style: .default, handler:{ ACTION in
            let newtask = taskalert.textFields![0]
            self.tasks.append(newtask.text!)
            self.taskTableView.reloadData()
        })
        
        let cancle = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        taskalert.addAction(addtask)
        taskalert.addAction(cancle)
       self.present(taskalert, animated: true)
        
        
    }

}

