//
//  HomeViewController.swift
//  To Do List
//
//  Created by Mac@IBM  on 28/02/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var tasks: [Task] = []
    var taskSelected = Task(id: "", descricao: "", status: "", data: "", idUser: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        setupTableView()
        showTimeLabel()
    }
    
    // MARK: PRIVATE FUNCTIONS
    fileprivate func getData(){
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            let uid = user.uid
            db.collection("tasks").whereField("IdUser", isEqualTo: uid).getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for doc in querySnapshot!.documents {
                        let data = doc.data()
                        tasks.append(Task(id: doc.documentID, descricao: data["Descricao"] as! String, status: data["Status"] as! String, data: data["Data"] as! String, idUser: data["IdUser"] as! String))
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    fileprivate func setupTableView(){
        // Instanciando o delegate e o dataSource.
        self.tableView.allowsSelection = true
        self.tableView.allowsFocus = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TaskCell", bundle: nil ), forCellReuseIdentifier: "ReusableCell")
    }
    
    // Passando por parametro os valores
    // MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "taskSegue") {
            let vc = segue.destination as? TaskViewController
            vc?.taskSelected = taskSelected
        }
    }
    
    //para esconder o navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //mostra mensagem inicial de acordo com o horário do sistema
    func showTimeLabel(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12 : (hourLabel.text = "Good Morning")
        case 12..<18 : (hourLabel.text = "Good Afternoon")
        case 18..<24 : (hourLabel.text = "Good Night")
        default:
            (hourLabel.text = "Hello")
        }
    }
    
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TaskCell
        cell.taskLabel.text = tasks[indexPath.row].descricao
        
        // Tarefas com status Undone desmarcadas no switch
        if tasks[indexPath.row].status == "Undone" {
            cell.taskSwitch.setOn(false, animated: true)
        }
        
        // Adicionando um target para pegar a mudanca do switch
        cell.taskSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
       
        // Para pegar qual a tarefa
        cell.taskSwitch.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.tasks[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        taskSelected = self.tasks[indexPath.row]
        performSegue(withIdentifier: "taskSegue", sender: self)
    }
    
    
    @objc func switchChanged(_ sender: UISwitch!) {
        print("the switch is \(sender.isOn ? "ON" : "OFF") ")
        
        let documentId = tasks[sender.tag].id
        if sender.isOn {
            self.tasks[sender.tag].status = "Done"
            db.collection("tasks").document(documentId).updateData(["Status" : "Done"])
            print("mudou para done")
        }
        else {
            self.tasks[sender.tag].status = "Undone"
            db.collection("tasks").document(documentId).updateData(["Status" : "Undone"])
            print("undone")
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            //Deletar o item no array tasks
            tasks.remove(at: indexPath.row)
            
            // deletar do banco
            let documentId = tasks[indexPath.row].id
            db.collection("tasks").document(documentId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}


