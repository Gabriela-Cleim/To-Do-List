//
//  TasksViewController.swift
//  To Do List
//
//  Created by Andressa Santos on 02/03/22.
//

import UIKit

class TasksViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var NewTask: UITextField!
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        NewTask.text = formatter.string(from: self.dataPicker.date)
        
            
        }
    
    }
        


    




