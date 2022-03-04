//
//  TaskViewController.swift
//  To Do List
//
//  Created by Natalia Sakai on 02/03/22.
//

import Foundation
import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var whenView: UIView!
    var taskSelected = Task(id: "", descricao: "", status: "", data: "", idUser: "")
    
    override func viewDidLoad() {
        taskView.layer.cornerRadius = 20
        whenView.layer.cornerRadius = 20
        
        if (taskSelected.status == "Done") {
            
        }
        
        descriptionLabel.text = taskSelected.descricao
        print(taskSelected)
    }
    //para mostrar o navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
