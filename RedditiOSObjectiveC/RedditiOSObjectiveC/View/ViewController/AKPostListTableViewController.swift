//
//  AKPostListTableViewController.swift
//  RedditiOSObjectiveC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class AKPostListTableViewController: UITableViewController {

    //MARK: - outlets
    @IBOutlet weak var postSearchBar: UISearchBar!
    
    //MARK: - properties
    var posts: [AKPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postSearchBar.autocapitalizationType = .none
        
        postSearchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? AKPostTableViewCell else { return UITableViewCell() }
        
        let post = posts[indexPath.row]
        //accessing the cells post property, which we defined in custom cell, and setting its value equal to what we got from our array
        cell.post = post
        return cell
    }

}

extension AKPostListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = postSearchBar.text, !searchTerm.isEmpty else { return }
        
        AKPostController.shared().searchForPost(withSearchTerm: searchTerm) { (posts, _) in
            self.posts = posts
        }
    }
}
