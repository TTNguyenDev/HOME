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
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        let totalOfMonth = Bussiness.manage.getTotalBalanceOfMonth() as NSNumber
        
        mTotalBalance.text = totalOfMonth.transferToCurrency
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