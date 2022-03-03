//
//  1ViewController.swift
//  teste
//
//  Created by Andressa Santos on 02/03/22.
//

import UIKit

class _ViewController: UIViewController {

    @IBOutlet weak var date: UITextField!
    
    private var datePicker: UIDatePicker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(ViewController.dateChanged(datePicker:)), for: .valueChanged)
        date.inputView = datePicker
    }
    
    func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        
        date.text = dateFormatter.string(for: datePicker.date)
        
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
    
