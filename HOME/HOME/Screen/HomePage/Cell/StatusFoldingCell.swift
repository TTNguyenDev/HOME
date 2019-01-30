//
//  StatusFoldingCell.swift
//  HOME
//
//  Created by TT Nguyen on 1/22/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FoldingCell

class StatusFoldingCell: FoldingCell {
    
    
    @IBOutlet var mUserStateTableView: UITableView!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        
        mUserStateTableView.delegate = self
        mUserStateTableView.dataSource = self
        mUserStateTableView.backgroundColor = #colorLiteral(red: 0.9313246608, green: 0.9452430606, blue: 0.9667271972, alpha: 1)
        mUserStateTableView.separatorColor = .clear
        
        mUserStateTableView.register(UINib(nibName: "UserStateTableViewCell", bundle: nil), forCellReuseIdentifier: "UserStateCell")
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:FoldingCell.AnimationType)-> TimeInterval {
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }
}

extension StatusFoldingCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserStateCell", for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
    
}
