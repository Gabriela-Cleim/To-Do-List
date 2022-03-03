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
    @IBOutlet var tableView: UITableView!
    
    
//     Para adicionar as terafas manualmente (depois ligar com o banco e apagar)
    struct Task {
        let taskName: String
    }
    
    var tasks: [Task] = [
        Task(taskName: "Limpar Casa"),
        Task(taskName: "Fazer dever"),
        Task(taskName: "Comprar pao"),
        Task(taskName: "Ir na esquina"),
        Task(taskName: "Faculdade"),
        Task(taskName: "Fazer alguma coisa")
        
    ]
// fim das tarefas
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TaskCell
//        cell.textLabel?.text = tasks[indexPath.row].taskName
        cell.taskLabel.text = tasks[indexPath.row].taskName
        return cell
        
    }
}

 

