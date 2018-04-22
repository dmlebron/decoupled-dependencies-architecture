//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by David Martinez-Lebron on 4/20/18.
//  Copyright © 2018 davaur. All rights reserved.
//
import Foundation
import Alamofire

class NetworkManager: Networking {
    
    static func get(fromUrl url: URL, completion: @escaping (Any?) -> ()) {
        Alamofire.request(url.absoluteString).responseJSON { (response) in
            print(response)
        }
    }
}
