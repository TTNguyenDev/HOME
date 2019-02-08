//
//  BalanceFoldingCell.swift
//  HOME
//
//  Created by TT Nguyen on 1/22/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FoldingCell

class BalanceFoldingCell: FoldingCell {
    
    @IBOutlet weak var mTotalBalance: UILabel!
    
    @IBOutlet var mTotalBalanceContainerView: UILabel!
    @IBOutlet var mTotalOfThisMonthContainerView: UILabel!
    @IBOutlet var mTotalFeesContainerView: UILabel!
    @IBOutlet var mRecievedContainerView: UILabel!
    
    let name = Notification.Name(rawValue: isDataDidChanged)
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        
        let totalOfMonth = Bussiness.manage.getTotalBalanceOfMonth() as NSNumber
        let totalFees = Bussiness.manage.getTotalFees() as NSNumber
        let recieved = Bussiness.manage.getRecieved() as NSNumber
        
        mTotalBalance.text = totalOfMonth.transferToCurrency
        mTotalBalanceContainerView.text = totalOfMonth.transferToCurrency
        mTotalOfThisMonthContainerView.text = totalOfMonth.transferToCurrency
        mTotalFeesContainerView.text = totalFees.transferToCurrency
        mRecievedContainerView.text = recieved.transferToCurrency
        
        NotificationCenter.default.addObserver(self, selector: #selector(recievedData), name: name, object: nil)
    }
    
    @objc func recievedData() {
        let totalOfMonth = Bussiness.manage.getTotalBalanceOfMonth() as NSNumber
        let totalFees = Bussiness.manage.getTotalFees() as NSNumber
        let recieved = Bussiness.manage.getRecieved() as NSNumber
        
        mTotalBalance.text = totalOfMonth.transferToCurrency
        mTotalBalanceContainerView.text = totalOfMonth.transferToCurrency
        mTotalOfThisMonthContainerView.text = totalOfMonth.transferToCurrency
        mTotalFeesContainerView.text = totalFees.transferToCurrency
        mRecievedContainerView.text = recieved.transferToCurrency
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:FoldingCell.AnimationType)-> TimeInterval {
        let durations = [0.33, 0.26, 0.26] 
        return durations[itemIndex]
    }
    
    
}


