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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    
    
    
    
    
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
        resetForm()

    }
    
    
    
    //invalid email
    func resetForm() {
        loginButton.isEnabled = false
        
        emailError.isHidden = false
        emailError.text = ""
        emailTF.text = ""
        
            
    }
    
    @IBAction func emailChange(_ sender: Any) {
        if let email = emailTF.text {
            
            if let errorMessage = invalidEmail(value: email) {
                
                emailError.text = errorMessage
                emailError.isHidden = false
                
            }else{
                emailError.isHidden = true
            }
                
        }
        
        checkForValidForm()
    }
    
    func invalidEmail( value: String) -> String?
    {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid email format"
        }
        
        return nil
    }
    
    func checkForValidForm(){
        if emailError.isHidden{
            loginButton.isEnabled = true
        }else{
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func loginButtonn(_ sender: Any) {
        resetForm()
    }//fim do cod do invalid email
    
    
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
