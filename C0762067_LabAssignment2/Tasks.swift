//
//  Tasks.swift
//  C0762067_LabAssignment2
//
//  Created by Mac on 2020-01-20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

import  CoreData

//var tasks : [String] = [" "]
//  var days : [Int] = [0]

class Task {
    
    internal init(datetime:String,task: String, numberOfdays: Int16, descript: String) {
      
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .medium
//        let date = datetime
//        let calender = Calendar.current
//        let hour = calender.component(.hour, from: date)
//        let min = calender.component(.minute, from: date)
//        let sec = calender.component(.second, from: date)
//        let day = calender.component(.day, from: date)
//        let month = calender.component(.month, from: date)
//        let year = calender.component(.year, from: date)

        self.datetime = datetime
        self.task = task
        self.numberOfdays = numberOfdays
        self.descript = descript
    }
    
    var datetime : String
    var task : String
    var numberOfdays : Int16
    var descript : String
    
   
}
extension Date {
    /**
     Formats a Date

     - parameters format: (String) for eg dd-MM-yyyy hh-mm-ss
     */
    func format(format:String = "dd-MM-yyyy hh-mm-ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        if let newDate = dateFormatter.date(from: dateString) {
            return newDate
        } else {
            return self
        }
    }
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

