//
//  LoginController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 20.04.24.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak private var loginEmailField: UITextField!
    @IBOutlet weak private var loginPasswordField: UITextField!
    @IBOutlet weak private var errorLabel: UILabel!
    
    var loginUser: LoginUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        errorLabel.isHidden = true
    }
    
    @IBAction func switchButton(_ sender: UISwitch) {
        if sender.isOn {
                   loginPasswordField.isSecureTextEntry = false
               } else {
                   loginPasswordField.isSecureTextEntry = true
               }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if loginEmailField.text == loginUser?.name && loginPasswordField.text == loginUser?.password {
//            let controller = storyboard?.instantiateViewController(withIdentifier: "\(HomeController.self)") as! HomeController
//            navigationController?.show(controller, sender: nil)
            
            if let window = UIApplication.shared.windows.first {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeController = mainStoryboard.instantiateViewController(withIdentifier: "HomeControllerID") as! HomeController
                window.rootViewController = homeController
                window.makeKeyAndVisible()
            }
            
            errorLabel.isHidden = true
        
            UserDefaults.standard.setValue(true, forKey: "userRegistered")
            
        } else if loginEmailField.text == "" || loginPasswordField.text == "" {
            errorLabel.text = "The email or password field is empty "
            errorLabel.isHidden = false
        } else {
            errorLabel.text = "The email or password is incorrect."
            errorLabel.isHidden = false
        }
    }
    
    @IBAction func registerTappedButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "\(RegisterController.self)") as! RegisterController
            controller.callback = { user in
            self.loginUser = LoginUser(name: user.email,
                                       password: user.password)
            self.loginEmailField.text = user.email
            self.loginPasswordField.text = user.password
        }
        navigationController?.show(controller, sender: nil)
        errorLabel.isHidden = true
    }
}
