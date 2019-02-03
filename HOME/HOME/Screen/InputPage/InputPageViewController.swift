//
//  InputPageViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView
import SCLAlertView

class InputPageViewController: BaseViewController, NVActivityIndicatorViewable {
    
    var mUserData = [UserData]()
    var mPreviousUserData = [UserData]()
    var mCalcalateButtonIsTouch = false
    
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
    
    fileprivate func setupIndicator() {
        let size = CGSize(width: 80, height: 80)
        let indicatorType = NVActivityIndicatorType.init(rawValue: 29)
        
        startAnimating(size, message: "Loading...", messageFont: UIFont.boldSystemFont(ofSize: 20), type: indicatorType, color: .red, padding: 2, displayTimeThreshold: 2, minimumDisplayTime: 2, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: .red, fadeInAnimation: nil)
    }
    
    
    fileprivate func confirmSaveDataAlert(confirmed: @escaping () -> Void) {
        let alert = SCLAlertView()
        _ = alert.addButton("Confirm") {
            confirmed()
        }
        _ = alert.showWarning("Confirm", subTitle: "Are you sure to save this data?")
    }
    
    @IBAction func exportButton(_ sender: Any) {
        if mCalcalateButtonIsTouch {
            setupIndicator()
            Bussiness.manage.ditInit {
                NVActivityIndicatorPresenter.sharedInstance.setMessage("Loading Success")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.stopAnimating()
                    let reviewDataViewController = ReviewDataViewController()
                    self.navigationController?.pushViewController(reviewDataViewController, animated: false)
                }
            }
        } else {
            let reviewDataViewController = ReviewDataViewController()
            navigationController?.pushViewController(reviewDataViewController, animated: false)
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        confirmSaveDataAlert {
            self.checkInputValue()
            self.mUserData.append(UserData(roomId: "p1_1", elecValue: Int(self.mElec_1_1.text!)!, waterValue: Int(self.mWater_1_1.text!)!))
            self.mUserData.append(UserData(roomId: "p1_2", elecValue: Int(self.mElec_1_2.text!)!, waterValue: Int(self.mWater_1_2.text!)!))
            self.mUserData.append(UserData(roomId: "p2_2", elecValue: Int(self.mElec_2_2.text!)!, waterValue: Int(self.mWater_2_2.text!)!))
            self.mUserData.append(UserData(roomId: "p3_1", elecValue: Int(self.mElec_3_1.text!)!, waterValue: Int(self.mWater_3_1.text!)!))
            self.mUserData.append(UserData(roomId: "p3_2", elecValue: Int(self.mElec_3_2.text!)!, waterValue: Int(self.mWater_3_2.text!)!))
            self.mUserData.append(UserData(roomId: "p4_2", elecValue: Int(self.mElec_4_2.text!)!, waterValue: Int(self.mWater_4_2.text!)!))
            
            //Calculate
            Bussiness.manage.calculateWith(previousUserData: self.mPreviousUserData, userData: self.mUserData)
            self.mCalcalateButtonIsTouch = true
        }
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
    
    fileprivate func checkInputValue() {
        mElec_1_1.text = mElec_1_1.text == "" ? "0" : mElec_1_1.text
        mWater_1_1.text = mWater_1_1.text == "" ? "0" : mWater_1_1.text
        
        mElec_3_1.text = mElec_3_1.text == "" ? "0" : mElec_3_1.text
        mWater_3_1.text = mWater_3_1.text == "" ? "0" : mWater_3_1.text
        
        mElec_1_2.text = mElec_1_2.text == "" ? "0" : mElec_1_2.text
        mWater_1_2.text = mWater_1_2.text == "" ? "0" : mWater_1_2.text
        
        mElec_2_2.text = mElec_2_2.text == "" ? "0" : mElec_2_2.text
        mWater_2_2.text = mWater_2_2.text == "" ? "0" : mWater_2_2.text
        
        mElec_3_2.text = mElec_3_2.text == "" ? "0" : mElec_3_2.text
        mWater_3_2.text = mWater_3_2.text == "" ? "0" : mWater_3_2.text
        
        mElec_4_2.text = mElec_4_2.text == "" ? "0" : mElec_4_2.text
        mWater_4_2.text = mWater_4_2.text == "" ? "0" : mWater_4_2.text
    }
    
    func observePreviousUserData() {
        API.user.observeUserDataWithDate(date: "01_2019", completion: { (previousUserData) in
            self.mPreviousUserData.append(previousUserData)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        observePreviousUserData()
        
       
    }
    
    @objc func firstButton() {
        print("First button tapped")
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
