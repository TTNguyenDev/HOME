//
//  cell.swift
//  HOME
//
//  Created by Trọng Tín on 09/02/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit

protocol InputCellDelegate: NSObject {
    func didEnterElecValue(indexRow: Int, textField: BaseNumberInput)
    func didEnterWaterValue(indexRow: Int, textField: BaseNumberInput)
    func clickSwitchWifi(indexRow: Int, switchWifi: UISwitch)
}


class CellUser: UITableViewCell {
    
    weak var delegate: InputCellDelegate?

    @IBOutlet var cellLayer: UILabel!
    @IBOutlet var roomID: UILabel!
    @IBOutlet var mElec: BaseNumberInput!
    @IBOutlet var mWater: BaseNumberInput!
    @IBOutlet var outWifi: UISwitch!
    
    var index: Int?
    
    @IBAction func mWifi(_ sender: Any) {
        delegate?.clickSwitchWifi(indexRow: index!, switchWifi: outWifi)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellLayer.layer.cornerRadius = 10.0
        cellLayer.layer.masksToBounds = true
        mElec.delegate = self
        mWater.delegate = self
    }
    
    override func prepareForReuse() {
        mElec.text = ""
        mWater.text = ""
    }
    
}

extension CellUser: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case mElec:
            delegate?.didEnterElecValue(indexRow: index!, textField: mElec)
        case mWater:
            delegate?.didEnterWaterValue(indexRow: index!, textField: mWater)
        default:
            break
        }
    }
}


//protocol
//delegate pattern
//            didEnterWaterValue?(13)
//            didEnterElecValue?(12)
