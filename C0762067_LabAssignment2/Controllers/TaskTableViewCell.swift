//
//  TaskTableViewCell.swift
//  C0762067_LabAssignment2
//
//  Created by Mac on 2020-01-20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var numberdaysLabel: UILabel!
    @IBOutlet weak var datelable: UILabel!
    @IBOutlet weak var taskLAble: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
