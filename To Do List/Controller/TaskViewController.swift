//
//  DetalheViewController.swift
//  To Do List
//
//  Created by Natalia Sakai on 01/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var pickerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.layer.cornerRadius = 20
        taskView.layer.cornerRadius = 20
    }
}
