//
//  AuthManager.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/02.
//

import Foundation
import FirebaseAuth


public class AuthManager {
    static let shared = AuthManager()
    
    
    //MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool)->Void) {
        /*
         - Check if username is available
         - Check if email is available
         */
        print("=== In registerNewUser ===")
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { (canCreate) in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else {
                        // Firebase auth could not create account
                        print("=== Cannot create")
                        completion(false)
                        return
                    }
                    
                    // Insert into database
                    
                    print("=== Can create ===")
                    
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (success) in
                        if success {
                            print("Successfully included in Database")
                            completion(true)
                            return
                        } else {
                            print("Failed included in Database")
                            completion(false)
                            return
                        }
                        
                        
                    }
                    
                }
            }
        }
        
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            // username log in
            print(username)
        }
        
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            
            print(error)
            completion(false)
            return
        }
    }
}


