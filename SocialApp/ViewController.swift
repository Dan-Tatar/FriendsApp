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
        
        fetchData()
    }

    func fetchData() {
        
        DispatchQueue.global().async {
            do {
                let urlString = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            
                guard let data = try? Data(contentsOf: urlString) else {
                    print("unable make contents of URL")
                    return
                }
                let decoder  = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
              
                
                guard let savedData = try? decoder.decode([Friend].self, from: data) else {
                    print("unable to decode data")
                    return
                }
                DispatchQueue.main.async {
                    self.friends = savedData
                    self.filteredFriends = savedData
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text =  friend.friends.map { $0.name }.joined(separator: " ")
            return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
            text.count > 0 {
            filteredFriends = friends.filter {
                $0.name.contains(text)
             }
            } else {
                filteredFriends = friends
            }
        tableView.reloadData()
    }
}
