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
        
        mTotalBalance.text = totalOfMonth.transferToCurrency
        mTotalBalanceContainerView.text = totalOfMonth.transferToCurrency
        mTotalOfThisMonthContainerView.text = totalOfMonth.transferToCurrency
        mTotalFeesContainerView.text = totalFees.transferToCurrency
        
        NotificationCenter.default.addObserver(self, selector: #selector(testListener), name: name, object: nil)
    }
    
    @objc func testListener() {
        let totalOfMonth = Bussiness.manage.getTotalBalanceOfMonth() as NSNumber
        let totalFees = Bussiness.manage.getTotalFees() as NSNumber
        
        mTotalBalance.text = totalOfMonth.transferToCurrency
        mTotalBalanceContainerView.text = totalOfMonth.transferToCurrency
        mTotalOfThisMonthContainerView.text = totalOfMonth.transferToCurrency
        mTotalFeesContainerView.text = totalFees.transferToCurrency
    }
    
    func currencyNumberFormat(number: Int) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: number))!
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:FoldingCell.AnimationType)-> TimeInterval {
        let durations = [0.33, 0.26, 0.26] 
        return durations[itemIndex]
    }
    
    
}


