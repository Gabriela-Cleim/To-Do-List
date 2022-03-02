//
//  HomeViewController.swift
//  To Do List
//
//  Created by Mac@IBM  on 28/02/22.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hourLabel: UILabel!
    
    override func viewDidLoad() {
        showTimeLabel()
    }
    
    //mostra mensagem inicial de acordo com o horário do sistema
    func showTimeLabel(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12 : (hourLabel.text = "Good Morning")
        case 12..<18 : (hourLabel.text = "Good Afternoon")
        case 18..<6 : (hourLabel.text = "Good Night")
        default:
            (hourLabel.text = "Hello")
        }
    }
    
    
}
