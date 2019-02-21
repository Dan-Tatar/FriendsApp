//
//  ExtensionJson.swift
//  FriendsApp
//
//  Created by Dan  Tatar on 11/02/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func decode<T:Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        
        guard let urlString = URL(string: url) else {
            fatalError("There is an issue with the URL")
        }
        DispatchQueue.global().async {
        do {
       let data = try Data(contentsOf: urlString)
            
        let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
        
       let downloadedData = try decoder.decode(type, from: data)
            
            DispatchQueue.main.async {
                completion(downloadedData)
            }
        
            } catch {
            print(error.localizedDescription)
            }
        }
    }
}






























//
//func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
//
//    guard let urlString = URL(string: url) else {
//        fatalError("URL not found")
//    }
//    DispatchQueue.global().async {
//        do {
//            let data = try Data(contentsOf: urlString)
//
//            let decoder  = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//
//
//            let downloadedData = try decoder.decode(type, from: data)
//
//            DispatchQueue.main.async {
//                completion(downloadedData)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//}
