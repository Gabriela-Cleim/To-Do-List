//
//  LoginViewController.swift
//  To Do List
//
//  Created by Gabriela Cleim on 27/02/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailError: UILabel!
    
    @IBAction func login(_ sender: Any) {
        //Para recuperar os dados digitados
        if let emailRecovered = self.email.text{
            if let passwordRecovered = self.password.text{
                
                //Cod para autenticar user
                let auth = Auth.auth()
                auth.signIn(withEmail: emailRecovered, password: passwordRecovered) { (user, erro) in
                    if erro == nil {
                        if user == nil {
                           
                        }else{
                            //Redireciona o usuario para a tela inicial
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        }
                    }else{
                        self.showAlert(titulo:"Error", mensagem:"Wrong email or password, please try again.")
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Alert
    func showAlert(titulo: String, mensagem: String){
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction( action )
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //para esconder o navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
