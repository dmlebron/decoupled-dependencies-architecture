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
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var resultsArray = [NSDictionary]() {
        didSet {
            artistNameLabel.text = resultsArray.first!["artistName"] as? String
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
}

// MARK: Selectors
@objc extension ViewController {
    func searchButtonTapped() {
        guard isArtistNameValid() else {
            return self.handleNoResponse()
        }
        
        self.search(forArtist: searchText.text!)
    }
}

// MARK: Private
private extension ViewController {
    private func handleNoResponse() {
        self.artistNameLabel.text = "Nothing Found"
    }
    
    private func search(forArtist artist: String) {
        ApiService.get(withResultType: Type.album, forArtist: artist, completion: { [unowned self] (response)  in
            guard let response = response else {
                self.handleNoResponse()
                return
            }
            self.resultsArray = response
        })
    }
    
    private func isArtistNameValid() -> Bool {
        guard let artist = searchText.text, !artist.isEmpty else {
            return false
        }
        return true
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = resultsArray[indexPath.row]["collectionName"] as? String
        
        return cell
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.resignFirstResponder()
        guard isArtistNameValid() else {
            return false
        }
        search(forArtist: searchText.text!)
        return true
    }
}
