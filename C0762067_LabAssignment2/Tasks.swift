//
//  Tasks.swift
//  C0762067_LabAssignment2
//
//  Created by Mac on 2020-01-20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

import  CoreData

class Task {
    internal init(datetime: Date, task: String, numberOfdays: Int32, descript: String) {
        self.datetime = datetime
        self.task = task
        self.numberOfdays = numberOfdays
        self.descript = descript
    }
    
    var datetime = Date()
    var task : String
    var numberOfdays : Int32
    var descript : String
    
    
}
