//
//  input.swift
//  HOME
//
//  Created by Trọng Tín on 09/02/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView
import SCLAlertView

class InputPage: BaseViewController {
    
    let nDidAddNewUser = Notification.Name(didAddNewUser)
    
    var numOfRoom: Int?
    var R_ID = [String]()
    var mUserData = [UserData]()
    var mPreviousUserData = [UserData]()
    var mCalcalateButtonIsTouch = false
    
    var isCollapse = false
    var numOfCell = 0
    let cellID = "hello"
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.setupTableView()
        self.setupData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeData), name: nDidAddNewUser, object: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = false
//        observePreviousUserData()
    }
    
    @objc func changeData() {
        setupData()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 4, width: self.view.frame.width, height: self.view.frame.height-(tabBarController?.tabBar.frame.height)!-15))
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellUser", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.sectionHeaderHeight = 60
    }
    
    private func setupData() {
        numOfRoom = Bussiness.manage.mUser.count
        if Bussiness.manage.isCurrentMonth {
            mPreviousUserData = Bussiness.manage.mPreviousUserData
        } else {
            mPreviousUserData = Bussiness.manage.mUserData
        }
        R_ID.removeAll()
        for i in 0 ..< numOfRoom! {
            R_ID.append(Bussiness.manage.mUser[i].mRoomId!)
        }
    }
}

extension InputPage: InputCellDelegate, NVActivityIndicatorViewable {
    
    func didEnterElecValue(indexRow: Int, textField: BaseNumberInput) {
        if textField.text != "" {
            if Int(textField.text!)! <= mPreviousUserData[indexRow].mElecValue! {
                createAlertWithSubTitle()
            } else {
                UserDefaults.standard.set(textField.text, forKey: String(indexRow))
            }
        } else {
            UserDefaults.standard.removeObject(forKey: String(indexRow))
        }
    }
    
    func didEnterWaterValue(indexRow: Int, textField: BaseNumberInput) {
        if textField.text != "" {
            if Int(textField.text!)! <= mPreviousUserData[indexRow].mWaterValue! {
                createAlertWithSubTitle()
            } else {
                UserDefaults.standard.set(textField.text, forKey: "-" + String(indexRow))
            }
        } else {
            UserDefaults.standard.removeObject(forKey: "-" + String(indexRow))
        }
    }
    
    func clickSwitchWifi(indexRow: Int, switchWifi: UISwitch) {
        UserDefaults.standard.set(switchWifi.isOn, forKey: String(indexRow) + "0")
    }
    
    func createAlertWithSubTitle() {
        let alert = SCLAlertView()
        _ = alert.showEdit("Wrong input value", subTitle: "Your value is smaller than the previous one")
    }

    @objc func test() {
        isCollapse = !isCollapse
        tableView.reloadData()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if (checkInputValue()) {
            confirmSaveDataAlert { [self] in
                for i in 0..<numOfRoom! {
                    mUserData.append(UserData(roomId: R_ID[i], elecValue: Int(UserDefaults.standard.string(forKey: String(i))!)!, waterValue: Int(UserDefaults.standard.string(forKey: "-" + String(i))!)!, isWifi: UserDefaults.standard.bool(forKey: String(i) + "0")))
                }
                
                //Calculate
                Bussiness.manage.calculateWith(previousUserData: self.mPreviousUserData, userData: self.mUserData)
                
                self.mCalcalateButtonIsTouch = true
                
                self.removeAllUserDefault()
                tableView.reloadData()
            }
        } else {
            let alert = SCLAlertView()
            _ = alert.showError("Can't calculate this data", subTitle: "You missing some value, please fill all and try again")
        }
    }
    
    func removeAllUserDefault() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    fileprivate func checkInputValue() -> Bool {
        for i in 0..<numOfRoom! {
            if (UserDefaults.standard.string(forKey: String(i)) == "" || UserDefaults.standard.string(forKey: "-" + String(numOfCell)) == "") {
                return false
            }
        }
        return true
    }
    
    fileprivate func confirmSaveDataAlert(confirmed: @escaping () -> Void) {
        let alert = SCLAlertView()
        _ = alert.addButton("Confirm") {
            confirmed()
        }
        _ = alert.showWarning("Confirm", subTitle: "Are you sure to save this data?")
    }
    
    @IBAction func reviewButton(_ sender: Any) {
        if mCalcalateButtonIsTouch {
            setupIndicator()
            Bussiness.manage.ditInit {
                NVActivityIndicatorPresenter.sharedInstance.setMessage("Loading Success")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.stopAnimating()
                    let reviewViewController = ReviewViewController()
                    self.navigationController?.pushViewController(reviewViewController, animated: false)
                }
            }
        } else {
            let reviewViewController = ReviewViewController()
            navigationController?.pushViewController(reviewViewController, animated: false)
        }
    }

    fileprivate func setupIndicator() {
        let size = CGSize(width: 80, height: 80)
        let indicatorType = NVActivityIndicatorType.ballPulse
        startAnimating(size, message: "Loading...", messageFont: UIFont.boldSystemFont(ofSize: 20), type: indicatorType, color: .red, padding: 2, displayTimeThreshold: 2, minimumDisplayTime: 2, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: .red, fadeInAnimation: nil)
    }
        
}

extension InputPage: UITableViewDelegate, UITableViewDataSource {
//table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 2, width: self.view.frame.width - 20, height: 60 - 4)
        button.layer.cornerRadius = CGFloat(7.0)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if (section == 0) {
            button.setTitle("Input Area", for: .normal)
            if (!isCollapse) {
                button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
            button.addTarget(self, action: #selector(test), for: .touchUpInside)
            header.addSubview(button)
        } else if (section == 1) {
                button.setTitle("Save", for: .normal)
                button.setTitle("Pressed + Hold", for: .highlighted)
                button.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        } else if (section == 2) {
                button.setTitle("Review", for: .normal)
                button.setTitle("Pressed + Hold", for: .highlighted)
                button.addTarget(self, action: #selector(reviewButton), for: .touchUpInside)
        }
        header.addSubview(button)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return isCollapse ? 0 : numOfRoom!
        } else {
            return 0
        }
    }
    
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        numOfCell = indexPath.row
        let placeHolder = "Previous Value: "
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellUser
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.delegate = self
        cell.index = numOfCell
        cell.roomID.text = "Room " + R_ID[numOfCell]
        if (numOfCell < mPreviousUserData.count) {
            cell.mElec.placeholder = placeHolder + String(mPreviousUserData[numOfCell].mElecValue!)
            cell.mWater.placeholder = placeHolder + String(mPreviousUserData[numOfCell].mWaterValue!)
            cell.outWifi.isOn = mPreviousUserData[numOfCell].mWifi ?? false
        } else {
            cell.mElec.placeholder = "Input Value"
            cell.mWater.placeholder = "Input Value"
            cell.outWifi.isOn = false
        }
        cell.mElec.text  = UserDefaults.standard.string(forKey: String(numOfCell)) ?? ""
        cell.mWater.text = UserDefaults.standard.string(forKey: "-" + String(numOfCell)) ?? ""
        cell.outWifi.isOn = UserDefaults.standard.bool(forKey: String(numOfCell) + "0")
        return cell
    }
   
}
