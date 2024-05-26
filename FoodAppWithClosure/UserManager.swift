//
//  UserManager.swift
//  BankAppWithClosureDelegate
//
//  Created by Zahra Alizada on 23.04.24.
//

import Foundation

class UserManager {
    static let shared = UserManager()

    var currentUser: RegisterUser?
    
    func setupUser(fullname: String, email: String, phone: String, password: String) {
        currentUser = RegisterUser(
                        fullname: fullname,
                        email: email,
                        phone: phone,
                        password: password
                )
    }

    private init() {}
}
