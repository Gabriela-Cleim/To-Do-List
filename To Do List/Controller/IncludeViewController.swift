//
//  IncludeViewController.swift
//  To Do List
//
//  Created by Andressa Santos on 03/03/22.
//

import UIKit
import Firebase
import FirebaseAuth

class IncludeViewController: UIViewController {
    
    let db = Firestore.firestore()
    
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
    
    @IBAction func saveBtn(_ sender: UIButton) {
        //verificar se os dois campos foram preenchidos
        
        
        //conexao com o banco
        let user = Auth.auth().currentUser
        if let user = user {
            db.collection("tasks").addDocument(data: [
                "Descricao": "Teste Natalia", //colocar o newTask.text,
                "Status": "Undone",
                "Data": "Teste",//colocar a data
                "IdUser": user.uid
            ])
            { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    //voltar para o home
                    
                }
            }
        }
        
    }
    

}
