//
//  TaskViewController.swift
//  To Do List
//
//  Created by Natalia Sakai on 02/03/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
class TaskViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var whenView: UIView!
    var taskSelected = Task(id: "", descricao: "", status: "", data: "", idUser: "")
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        setupView()
    }
    
    // MARK: PRIVATE FUNCTIONS
    fileprivate func setupView(){
        taskView.layer.cornerRadius = 20
        whenView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = 15
        datePicker.isEnabled = false
        if (taskSelected.status == "Done") {
            doneButton.isEnabled = false
            doneButton.setTitle("Task Done", for: UIControl.State.normal)
            doneButton.backgroundColor = UIColor.lightGray
        }
        
        descriptionLabel.text = taskSelected.descricao
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM-dd-yyyy HH:mm"
        let date = dateFormatter.date(from: taskSelected.data)
        datePicker.date = date!
    }
    
    // MARK: 
    //para mostrar o navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // Passando por parametro os valores
    // MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "homeSegue") {
            let vc = segue.destination as? HomeViewController
        }
    }
    
    //Alert
    func showAlert(titulo: String, mensagem: String){
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: {_ in
            self.db.collection("tasks").document(self.taskSelected.id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            self.performSegue(withIdentifier: "homeSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .destructive, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doneClick(_ sender: Any) {
        db.collection("tasks").document(taskSelected.id).updateData(["Status" : "Done"])
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
    @IBAction func deleteClick(_ sender: Any) {
        self.showAlert(titulo:"Warning", mensagem:"If you remove this task, it will be deleted and can`t be recovered, are you sure?")
    }
}
