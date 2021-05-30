//
//  FutureCall.swift
//  Instagram
//
//  Created by Punreach Rany on 2021/05/30.
//

import Foundation

public class FutureCall {
    static let shared =  FutureCall()
    
    public func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
