//
//  RegisterViewController.swift
//  To Do List
//
//  Created by Gabriela Cleim on 27/02/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var auth: Auth!
    var firestore: Firestore!
    
    
    
    
    @IBAction func register(_ sender: Any) {
        //Para recuperar os dados digitados
        if let emailRecovered = self.email.text{
            if let passwordRecovered = self.password.text{
                if let passwordConfirmR = self.confirmPassword.text {
                    if let nameRecovered = self.name.text{
                        
                        //Para confirmar se as senhas são iguais
                        if passwordRecovered == passwordConfirmR {
                            
                            
                            
                            //Criar conta
                            let auth = Auth.auth()
                            auth.createUser(withEmail: emailRecovered, password: passwordRecovered) { (userR, erro) in
                                if erro == nil {
                                    
                                    //para salvar dados dos usuarios
                                    if let idUser = userR?.user.uid {
                                        self.firestore.collection("Users")
                                            .document( idUser )
                                            .setData([
                                                "name": nameRecovered,
                                                "email": emailRecovered
                                            ])
                                    }
                                }else{
                                    print("Erro ao cadastrar")
                                }
                                if userR == nil {
                                    self.showAlert(titulo:"Error", mensagem:"Wrong email or password, please try again.")
                                }else{
                                    //Redireciona o usuario para a tela inicial
                                    self.performSegue(withIdentifier: "registerSegue", sender: nil)
                                }
                            }
                            
                            
                        }else{
                            //Alert
                            self.showAlert(titulo:"Error", mensagem:"Passwords must be the same, please try again.")
                            //Fim cod alert
                        }
                        //Fim do cod de confirmar senha
                    }
                }
            }
        }
    }
    
    
     /*@IBAction func registerButton(_ sender: Any) {
        
        if let name = name.text{
            if let email = email.text{
                if let password = password.text{
                    if let confirmPassword = confirmPassword.text{
                        
                        auth.createUser(withEmail: email, password: password) { (user, erro) in
                            if erro == nil {
                                //para salvar dados dos usuarios
                                if let idUser = user?.user.uid {
                                self.firestore.collection("Users")
                                .document( idUser )
                                .setData([
                                "name": name,
                                "email": email
                                ])
                                }
                            }
                    }
                    }else{
                        self.showAlert(titulo:"Error", mensagem:"Password is empty, please try again.")
                    }
                }else{
                    self.showAlert(titulo:"Error", mensagem:"Password is empty, please try again.")
                }
            }else{
                self.showAlert(titulo:"Error", mensagem:"Email is empty, please try again.")
            }
        }else{
            self.showAlert(titulo:"Error", mensagem:"Name is empty, please try again.")
        }
    }*/
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firestore = Firestore.firestore()
        auth = Auth.auth()
        
        
    }
    
    //Alert
    func showAlert(titulo: String, mensagem: String){
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction( action )
        present(alert, animated: true, completion: nil)
    }
    
    //para mostrar o navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
