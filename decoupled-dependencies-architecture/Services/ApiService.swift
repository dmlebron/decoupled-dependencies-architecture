//
//  ApiService.swift
//  unit-test-dependencies-tutorial
//
//  Created by David Martinez-Lebron on 4/18/18.
//  Copyright © 2018 David Martinez-Lebron. All rights reserved.
//

import Foundation

public enum UrlAddress {
    
    static let base = "https://jobs.github.com/positions.json"
    
    case parameters(parameters: [Parameter: String])
    
    var full: String {
        
        if case let UrlAddress.parameters(parameters) = self {
            
            let encodedParams = parameters.reduce("") { (result, key) in
                guard let encodedValue = key.value.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else { return "" }
                return result + "&\(key.key.rawValue)=\(encodedValue)"
            }
            
            return "\(UrlAddress.base)?\(encodedParams)"
        }
        return UrlAddress.base
    }
}

public enum Parameter: String {
    case description
    case location
}

public final class ApiService {
    
    public static func get(forCityQuery city: String, completion: @escaping ([NSDictionary]?) -> ()) {
        let stringUrl = UrlAddress.parameters(parameters: [Parameter.description: "ios", Parameter.location: city]).full
        guard let url = URL(string: stringUrl) else { return completion(nil) }
        NetworkManager.get(fromUrl: url) { (response) in
            guard let response = response as? [NSDictionary] else {
                return completion(nil)
            }
            completion(response)
        }
        
    }
    
}
