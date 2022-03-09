//
//  LoginViewController.swift
//  To Do List
//
//  Created by Gabriela Cleim on 27/02/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 15
        
        emailTF.layer.cornerRadius = 20
        emailTF.clipsToBounds = true
        
        password.layer.cornerRadius = 20
        password.clipsToBounds = true
        
        
        resetForm()
        
        auth = Auth.auth()
        
        
        
        loginButton.isEnabled = false;
                password.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if password.text == "" || emailTF.text == ""{
                loginButton.isEnabled = false;
                loginButton.backgroundColor = UIColor.lightGray
                
            }else{
                 loginButton.isEnabled = true;
                 loginButton.backgroundColor = UIColor.strongCiano
            }
        }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        
        do{
            try auth.signOut()
        }catch{
            print("Erro")
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
        //Para recuperar os dados digitados
        if let emailRecovered = self.emailTF.text, let passwordRecovered = self.password.text {
            //Cod para autenticar user
            let auth = Auth.auth()
            auth.signIn(withEmail: emailRecovered, password: passwordRecovered) { (user, erro) in
                if erro != nil{
                    self.showAlert(titulo:"Error", mensagem:"Wrong email or password, please try again.")
                }
                else if user != nil{
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
            }
        }
    }
    
    //invalid email
    func resetForm() {
        loginButton.backgroundColor = UIColor.lightGray
        emailError.isHidden = false
        emailError.text = ""
        emailTF.text = ""
        password.text = ""
        
    }
    
    
    @IBAction func emailChange(_ sender: Any) {
        if let email = emailTF.text {
            
            if let errorMessage = invalidEmail(value: email) {
                
                emailError.text = errorMessage
                emailError.isHidden = false
                
                emailTF.layer.borderWidth = 1.0
                emailTF.layer.borderColor = UIColor.red.cgColor
                
            }else{
                emailError.isHidden = true
                emailTF.layer.borderWidth = 0
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
        if emailError.isHidden  {
            //loginButton.isEnabled = true
            print("hidden")
            
        }else{
            //loginButton.isEnabled = false
            print("enabled")
            
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
