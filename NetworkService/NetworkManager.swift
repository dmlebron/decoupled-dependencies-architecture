//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by David Martinez-Lebron on 4/20/18.
//  Copyright © 2018 davaur. All rights reserved.
//
import Foundation

class NetworkManager: Networking {

    static func get(fromUrl url: URL, completion: @escaping (Any?) -> ()) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(nil)
            }
            do {
                let deserialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                DispatchQueue.main.async {
                    completion(deserialized)
                }

            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            }.resume()
    }
}
