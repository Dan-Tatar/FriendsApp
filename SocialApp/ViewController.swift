//
//  ViewController.swift
//  SocialApp
//
//  Created by Dan  Tatar on 10/02/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {

    var friends = [Friend]()
    var filteredFriends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find your friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
   
        decoder.decode([Friend].self, fromURL: urlString) { friends in
            
        self.friends = friends
        self.filteredFriends = friends
        self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text =  friend.joinedNames
            return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredFriends = friends.matching(searchController.searchBar.text)
        tableView.reloadData()
    }
}
