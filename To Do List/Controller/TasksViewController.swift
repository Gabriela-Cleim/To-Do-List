//
//  TasksViewController.swift
//  To Do List
//
//  Created by Andressa Santos on 01/03/22.
//

import UIKit

class TasksViewController: UIViewController {
   
    @IBOutlet weak var newtaskText: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()


    }
    
    func createDatePicker() {
        
        newtaskText.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let createButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(createPressed))
        toolbar.setItems([createButton], animated: true)
        
        
        newtaskText.inputAccessoryView = toolbar
        
        newtaskText.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    @objc func createPressed(){
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        newtaskText.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}
