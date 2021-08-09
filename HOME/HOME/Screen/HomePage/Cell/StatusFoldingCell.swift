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
    
    var mUserData = [UserData]()
    var mRoomTotalValue = [Int]()
    let name = Notification.Name(rawValue: isDataDidChanged)
    var numberOfRoom = Int()
    
    @IBOutlet var process: UILabel!
    @IBOutlet var mProcessValue: UILabel!
    @IBOutlet var mStatusSlider: UISlider!
    @IBOutlet var mUserStateTableView: UITableView!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        numberOfRoom = Bussiness.manage.mUser.count
        fillUserData()
        mUserStateTableView.delegate = self
        mUserStateTableView.dataSource = self
        mUserStateTableView.backgroundColor = #colorLiteral(red: 0.9313246608, green: 0.9452430606, blue: 0.9667271972, alpha: 1)
        mUserStateTableView.separatorColor = .clear
//        mUserStateTableView.heightAnchor.constraint(equalToConstant: mUserStateTableView.rowHeight * 4 + process.layer.frame.height).isActive = true
        self.frame.size.height = mUserStateTableView.rowHeight * 4 + process.layer.frame.height
        mUserStateTableView.register(UINib(nibName: "UserStateTableViewCell", bundle: nil), forCellReuseIdentifier: "UserStateCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(recievedData), name: name, object: nil)
    }
    
    @objc func recievedData() {
        mStatusSlider.value += Float(1.0/Double(numberOfRoom))
        mProcessValue.text = String(mStatusSlider.value*100) + "%"
    }

    func fillUserData() {
        mUserData = Bussiness.manage.getUserData()
        mRoomTotalValue = Bussiness.manage.getTotalOfEachRoom()
        
        Bussiness.manage.getUserData().forEach { (userData) in
            if userData.mState! {
                mStatusSlider.value += Float(1.0/Double(numberOfRoom))
                print(mStatusSlider.value)
            }
        }
         mStatusSlider.setThumbImage(UIImage(), for: .normal)
         mProcessValue.text = String(mStatusSlider.value*100) + "%"
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:FoldingCell.AnimationType)-> TimeInterval {
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }
}

extension StatusFoldingCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRoom
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserStateCell", for: indexPath) as! UserStateTableViewCell
        
        let mRoomValue = mRoomTotalValue[indexPath.row] as NSNumber
        cell.mRoomTotalValue.text = mRoomValue.transferToCurrency
        cell.mRoomId.text = mUserData[indexPath.row].mRoomId
        cell.backgroundColor = .clear
        
        if mUserData[indexPath.row].mState! ||  mRoomTotalValue[indexPath.row] == 0 {
             cell.checkBox.setCheckState(.checked, animated: true)
             cell.isUserInteractionEnabled = false
        }
        
        cell.buttonAction = { sender in
            Bussiness.manage.setUserStateByIdNumber(idNumber: indexPath.row)
        }
        return cell
    }
    
}
