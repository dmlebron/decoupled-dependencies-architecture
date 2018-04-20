//
//  ViewController.swift
//  decoupled-dependencies-architecture
//
//  Created by David Martinez-Lebron on 4/18/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import UIKit
import NetworkManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ApiService.get(forCityQuery: "San Franciscostaoiuehoeifhroie", completion: { (response)  in
            print(response ?? "Empty")
        })
    }
}

