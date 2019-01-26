//
//  InputPageViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InputPageViewController: BaseViewController {
    
    var mUserData = [UserData]()
    var mPreviousUserData = [UserData]()
    
    //Phòng 1.1
    @IBOutlet var mElec_1_1: BaseTextInput!
    @IBOutlet var mWater_1_1: BaseTextInput!
    
    //Phòng 3.1
    @IBOutlet var mElec_3_1: BaseTextInput!
    @IBOutlet var mWater_3_1: BaseTextInput!
    
    //Phòng 1.2
    @IBOutlet var mElec_1_2: BaseTextInput!
    @IBOutlet var mWater_1_2: BaseTextInput!
    
    //Phòng 2.2
    @IBOutlet var mElec_2_2: BaseTextInput!
    @IBOutlet var mWater_2_2: BaseTextInput!
    
    //Phòng 3.2
    @IBOutlet var mElec_3_2: BaseTextInput!
    @IBOutlet var mWater_3_2: BaseTextInput!
    
    //Phòng 4.2
    @IBOutlet var mElec_4_2: BaseTextInput!
    @IBOutlet var mWater_4_2: BaseTextInput!
    
    
    @IBOutlet var mShowInputUser: UIButton!
    @IBOutlet var mainStack: UIStackView!
    @IBOutlet var stack: UIStackView!
    
    
    @IBAction func exportButton(_ sender: Any) {
        let reviewDataViewController = ReviewDataViewController()
        navigationController?.pushViewController(reviewDataViewController, animated: true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        //Save UserData
        mUserData.append(UserData(roomId: "p1_1", elecValue: Int(mElec_1_1.text!)!, waterValue: Int(mWater_1_1.text!)!))
        mUserData.append(UserData(roomId: "p1_2", elecValue: Int(mElec_1_2.text!)!, waterValue: Int(mWater_1_2.text!)!))
        mUserData.append(UserData(roomId: "p2_2", elecValue: Int(mElec_2_2.text!)!, waterValue: Int(mWater_2_2.text!)!))
        mUserData.append(UserData(roomId: "p3_1", elecValue: Int(mElec_3_1.text!)!, waterValue: Int(mWater_3_1.text!)!))
        mUserData.append(UserData(roomId: "p3_2", elecValue: Int(mElec_3_2.text!)!, waterValue: Int(mWater_3_2.text!)!))
        mUserData.append(UserData(roomId: "p4_2", elecValue: Int(mElec_4_2.text!)!, waterValue: Int(mWater_4_2.text!)!))
        
        //Calculate
        Bussiness.manage.calculateWith(previousUserData: mPreviousUserData, userData: mUserData)
        
    }
    
    @IBAction func showInputUser(_ sender: Any) {
        if stack.isHidden {
            mShowInputUser.setImage(UIImage(named: "hide"), for: .normal)
        } else {
            mShowInputUser.setImage(UIImage(named: "show"), for: .normal)
        }
        
        self.stack.isHidden = !self.stack.isHidden
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .showHideTransitionViews, animations: {
            self.mainStack.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func DEBUGFUNC() {
        mElec_1_1.text = "13"
        mElec_3_1.text = "13"
        mElec_1_2.text = "13"
        mElec_2_2.text = "13"
        mElec_3_2.text = "13"
        mElec_4_2.text = "13"
        
        mWater_1_1.text = "13"
        mWater_3_1.text = "13"
        mWater_1_2.text = "13"
        mWater_2_2.text = "13"
        mWater_3_2.text = "13"
        mWater_4_2.text = "13"
    }
    
    func presentPreviousUserData() {
        API.user.observeUserDataWithDate(date: "01_2019", completion: { (previousUserData) in
            self.mPreviousUserData.append(previousUserData)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        DEBUGFUNC()
        presentPreviousUserData()
    }
}

extension InputPageViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputPageViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
