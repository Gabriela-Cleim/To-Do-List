//
//  TaskCell.swift
//  To Do List
//
//  Created by Emanuelle Moço on 02/03/22.
//

import UIKit

class TaskCell: UITableViewCell {

   
    @IBOutlet var taskSwitch: UISwitch!
    @IBOutlet var taskLabel: UILabel!
    
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
