//
//  ViewController.swift
//  SocialApp
//
//  Created by Dan  Tatar on 10/02/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text =  friend.friends.map { $0.name }.joined(separator: " ")
            return cell
    }
}
