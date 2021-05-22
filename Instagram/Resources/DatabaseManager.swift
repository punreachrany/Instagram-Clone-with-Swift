//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/02.
//

import Foundation
import Firebase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let db = Firestore.firestore()
    
    //MARK: - Public
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts new user data to database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callbackl for result if database entry succeeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        let docData : [String: Any] = [
            "username" : username,
            "email" : email,
        ]
        
        db.collection("users").document(email).setData(docData) { err in
            if let err = err {
                print("Error Adding document \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(email)")
                completion(true)
            }
        }
        
    }

}


