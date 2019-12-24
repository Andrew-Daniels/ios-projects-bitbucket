//
//  AccountSingleton.swift
//  MealPrepr
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import FirebaseAuth

class AccountSingleton {
    
    public var user = User()
    private var _isLoggedIn: Bool = false
    
    static let instance = AccountSingleton()
    
    private init() {
        
    }
    
    required public init(from encoder: Encoder) throws {
        
    }
    
    public func isLoggedIn() -> AccountSingleton? {
        return _isLoggedIn || isAuthenticated() ? AccountSingleton.instance : nil
    }
    
    public func login(withEmail: String, password: String, asyncCompleteWith: @escaping (Result<AccountSingleton, Error>) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { (authResult, error) in
            if let error = error {
                asyncCompleteWith(.failure(error))
            }
            else if self.isAuthenticated() {
                asyncCompleteWith(.success(AccountSingleton.instance))
            }
            else {
                asyncCompleteWith(.failure(AccountError.NotAuthenticated))
            }
        }
    }
    
    public func createAccount(email: String, password: String, firstName: String, lastName: String, asyncCompleteWith: @escaping (Result<AccountSingleton, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
            if let error = err, let _ = AuthErrorCode(rawValue: error._code) {
                asyncCompleteWith(.failure(error))
            } else {
                let changeRequest = authResult!.user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstName)|\(lastName)"
                changeRequest.commitChanges { (error) in
                    if let err = error {
                        asyncCompleteWith(.failure(err))
                    }
                    else if self.isAuthenticated() {
//                        let _ = EntityFactorySingleton.instance.users.insertOrUpdate(object: self.user)
                        asyncCompleteWith(.success(AccountSingleton.instance))
                    }
                    else {
                        asyncCompleteWith(.failure(AccountError.NotAuthenticated))
                    }
                }
            }
        }
    }
    
    public func logout() -> Bool {
        if _isLoggedIn {
            do {
                try Auth.auth().signOut()
                _isLoggedIn = false
            }
            catch {
                return false
            }
        }
        return !_isLoggedIn
    }
    
    private func isAuthenticated() -> Bool {
        guard let user = Auth.auth().currentUser
            else {
                self.user = User()
                self._isLoggedIn = false
                return false
        }
        self.user.email = user.email
        self.user.id = user.uid
        let name = user.displayName?.split(separator: "|") ?? ["",""]
        self.user.firstName = "\(name[0])"
        self.user.lastName = "\(name[1])"
        self._isLoggedIn = true
        user.getIDTokenForcingRefresh(true) { (idToken, error) in
            if let error = error {
              print(error)
              return
            }

            // Send token to your backend via HTTPS
            // ...
            print(idToken!)
        }
        return true
    }
}

public enum AccountError: String, Error {
    case NotAuthenticated = "Your account was not able to be authenticated with the server"
    
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}
