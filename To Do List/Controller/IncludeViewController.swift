//
//  IncludeViewController.swift
//  To Do List
//
//  Created by Andressa Santos on 03/03/22.
//

import UIKit

class IncludeViewController: UIViewController {
    
    
    @IBOutlet weak var newTask: UITextField!
    
    private var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(IncludeViewController.dateChanged(datePicker:)), for: .valueChanged)
        newTask.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        
        newTask.text = dateFormatter.string(for: datePicker.date)
        
        view.endEditing(true)
    
    
    }
    


}
