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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let db = Firestore.firestore()
    
//     Para adicionar as terafas manualmente (depois ligar com o banco e apagar)
    struct Task {
        var id: String
        var descricao: String
        var status: String
        var data: String
        var idUser: String
    }
    
    var tasks: [Task] = []
// fim das tarefas
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskCell", bundle: nil ), forCellReuseIdentifier: "ReusableCell")
        
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

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TaskCell
        cell.taskLabel.text = tasks[indexPath.row].descricao
        
        // Adicionando um target para pegar a mudanca do switch
        cell.taskSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
       
        // Para pegar qual a tarefa
        cell.taskSwitch.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.tasks[indexPath.row])
    }
    
    @objc func switchChanged(_ sender: UISwitch!) {
            print ("changed ")
            print("the switch is \(sender.isOn ? "ON" : "OFF") ")
        

            // Mudando o status da task
            self.tasks[sender.tag].status = "Done"
                // quando for fazer com o bdd, checar se o sender ta on ou off
            print("sender tag: \(sender.tag)")
            
        }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            print("TESTEEEEE")
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


