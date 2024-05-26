//
//  RegisterController.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 20.04.24.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak private var regFullnameTextField: UITextField!
    @IBOutlet weak private var regEmailTextField: UITextField!
    @IBOutlet weak private var regPhoneTextField: UITextField!
    @IBOutlet weak private var regPasswordTextField: UITextField!
    @IBOutlet weak var regErrorLabel: UILabel!
    
    var callback: ((RegisterUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        regErrorLabel.isHidden = true
    }

    @IBAction func switchTappedButton(_ sender: UISwitch) {
        if sender.isOn {
            regPasswordTextField.isSecureTextEntry = false
        } else {
            regPasswordTextField.isSecureTextEntry = true
        }
        
    }
    @IBAction func registerTappedButton(_ sender: Any) {
        
        if regFullnameTextField.text == "" ||
           regEmailTextField.text == "" ||
           regPhoneTextField.text == "" ||
           regPasswordTextField.text == "" {
            regErrorLabel.text = "Please fill in all the empty cells."
            regErrorLabel.isHidden = false
        } else {
            UserManager.shared.setupUser(fullname: regFullnameTextField.text ?? "",
                                         email: regEmailTextField.text ?? "",
                                         phone: regPhoneTextField.text ?? "",
                                         password: regPasswordTextField.text ?? "")
        
            if let newUser = UserManager.shared.currentUser {
                    callback?(newUser)
                }
            navigationController?.popViewController(animated: true)
        }
    }
}
