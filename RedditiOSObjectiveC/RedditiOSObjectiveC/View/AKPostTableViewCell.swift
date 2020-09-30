//
//  AKPostTableViewCell.swift
//  RedditiOSObjectiveC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class AKPostTableViewCell: UITableViewCell {

    //MARK: - outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var upvoteCountLabel: UILabel!
    
    //MARK: - properties
    var post: AKPost? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - helpers
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        commentCountLabel.text = "\(post.commentCount) 👁‍🗨"
        upvoteCountLabel.text = "\(post.commentCount) ⬆️"
    }

}
