//
//  1ViewController.swift
//  teste
//
//  Created by Andressa Santos on 02/03/22.
//

import UIKit

class _ViewController: UIViewController {

    @IBOutlet weak var new: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.dateFormat = "dd/MM/yyyy"
                
        new.text = formatter.string(from: self.datePicker.date)
    }
        
        
    @IBAction func selection(_ sender: Any) {
        new.text = formatter.string(from: self.datePicker.date)
    }
    

}
    
