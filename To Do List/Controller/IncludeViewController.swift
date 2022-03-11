//
//  IncludeViewController.swift
//  To Do List
//
//  Created by Andressa Santos on 03/03/22.
//

import UIKit
import Firebase
import FirebaseAuth

class IncludeViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var newTask: UITextField!
    @IBOutlet weak var dateTask: UITextField!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    private var datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        setLayoutDetails(newTask)
        setLayoutDetails(dateTask)
        
        
        saveBtn.isEnabled = false
        newTask.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        dateTask.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.allEditingEvents )
        dateTask.delegate = self
    }
    
    func setLayoutDetails(_ textfield: UITextField) {
        saveBtn.layer.cornerRadius = 15
        
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.layer.cornerRadius = 25
        textfield.clipsToBounds = true
    }
    
    func createDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(IncludeViewController.dateChanged(datePicker:)), for: .valueChanged)
        dateTask.inputView = datePicker
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTask {
            return false; //do not show keyboard nor cursor
        }
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        dateTask.text = dateFormatter.string(for: datePicker.date)
        
        view.endEditing(true)
    }
    

    @objc func textFieldDidChange(_ sender: UITextField) {
        if newTask.text == "" || dateTask.text == ""{
            saveBtn.isEnabled = false;
            saveBtn.backgroundColor = UIColor.lightGray

        }else{
            saveBtn.isEnabled = true;
            saveBtn.backgroundColor = UIColor.strongCiano
        }
    }
    
        
    @IBAction func saveBtn(_ sender: Any) {
        if (newTask.text == "" || dateTask.text == "") {
              labelText.text = "Preencha todos os campos..."
        }else if newTask.text != nil, dateTask.text != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                db.collection("tasks").addDocument(data: [
                    "Descricao": newTask.text != nil,
                    "Status": "Undone",
                    "Data": dateTask.text != nil,
                    "IdUser": user.uid
                ])
                { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }


}
