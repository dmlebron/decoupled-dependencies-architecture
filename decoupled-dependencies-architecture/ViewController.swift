//
//  ViewController.swift
//  decoupled-dependencies-architecture
//
//  Created by David Martinez-Lebron on 4/18/18.
//  Copyright © 2018 davaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var artistNameText: UITextField!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var resultsArray = [NSDictionary]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        ApiService.get(withResultType: Type.album, forArtist: "Mago de oz", completion: { [unowned self] (response)  in
            guard let response = response else {
                self.artistNameLabel.text = "No Artist"
                return
            }
            self.resultsArray = response
        })
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButton.resignFirstResponder()
        return true
    }
}
