//
//  MePageViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit

let isRoomFeesChange = "activeWhenChangeRoomFees"
let isClickedClearButton = "clearAllDataDidInput"
let isClickedSaveButton = "saveDataDidInput"

class MePageViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    
    var isCollapseSection1 = false
    var isCollapseSection2 = false
    
    var nIsRoomFeesChange = Notification.Name(isRoomFeesChange)
    var nIsClickedClearButton = Notification.Name(isClickedClearButton)
    var nIsClickedSaveButton = Notification.Name(isClickedSaveButton)
    var nDidAddNewUser = Notification.Name(didAddNewUser)
    
    var mUser = [User]()
    var isClickEdit = [Bool]()
    
    var cellIDForDisplay = "123"
    var cellIDForAddRoom = "456"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeData), name: nDidAddNewUser, object: nil)
        self.navigationController?.navigationBar.prefersLargeTitles = false

    }

    func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 4, width: view.frame.width, height: view.frame.height-(tabBarController?.tabBar.frame.height)!-15)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellInfoUser", bundle: nil), forCellReuseIdentifier: cellIDForDisplay)
        tableView.register(UINib(nibName: "CellAdd", bundle: nil), forCellReuseIdentifier: cellIDForAddRoom)
        tableView.sectionHeaderHeight = 60
    }
    
    func setupData() {
        mUser.removeAll()
        while (isClickEdit.count < Bussiness.manage.mUser.count+1) {
            isClickEdit.append(false)
        }
        mUser = Bussiness.manage.mUser
    }
    
    
    
    @objc func changeData() {
        setupData()
        tableView.reloadData()
    }
}

extension MePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isCollapseSection1 ? mUser.count: 0
        } else {
            return isCollapseSection2 ? 1: 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 7, width: self.view.frame.width - 20, height: 60 - 7)
        button.layer.cornerRadius = CGFloat(7.0)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        header.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if (section == 0) {
            button.setTitle("Current User Data", for: .normal)
            if (isCollapseSection1) {
                button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
            button.addTarget(self, action: #selector(showCurrentUserData), for: .touchUpInside)
        } else if (section == 1) {
                button.setTitle("New Room", for: .normal)
            if isCollapseSection2 {
                button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
                button.addTarget(self, action: #selector(showNewRoom), for: .touchUpInside)
        }
        header.addSubview(button)
        return header
    }
    
    @objc func showCurrentUserData() {
        isCollapseSection1 = !isCollapseSection1
        tableView.reloadData()
    }
    
    @objc func showNewRoom() {
        isCollapseSection2 = !isCollapseSection2
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDForAddRoom, for: indexPath) as! CellAdd
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDForDisplay, for: indexPath) as! CellInfoUser
            cell.roomID.text = mUser[indexPath.row].mRoomId!
            cell.roomID.font = UIFont.boldSystemFont(ofSize: 20)
            cell.roomID.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            cell.index = indexPath
            if isClickEdit[indexPath.row] {
                cell.doneButton.isHidden = false
                cell.mUserName.text = mUser[indexPath.row].mUsername!
                cell.mDateJoined.text = mUser[indexPath.row].mDateJoined!
                cell.FirstDeposit.text = String(mUser[indexPath.row].mFirstDeposit!)
                cell.mPhoneNumber.text = mUser[indexPath.row].mPhoneNumber!
                cell.mRoomFees.text = String(mUser[indexPath.row].mRoomFees!)
            } else {
                cell.mUserName.placeholder = mUser[indexPath.row].mUsername!
                cell.mDateJoined.placeholder = mUser[indexPath.row].mDateJoined!
                cell.FirstDeposit.placeholder = String(mUser[indexPath.row].mFirstDeposit!)
                cell.mPhoneNumber.placeholder = mUser[indexPath.row].mPhoneNumber!
                cell.mRoomFees.placeholder = String(mUser[indexPath.row].mRoomFees!)
            }
            cell.mUserName.isUserInteractionEnabled = isClickEdit[indexPath.row]
            cell.mDateJoined.isUserInteractionEnabled = isClickEdit[indexPath.row]
            cell.FirstDeposit.isUserInteractionEnabled = isClickEdit[indexPath.row]
            cell.mPhoneNumber.isUserInteractionEnabled = isClickEdit[indexPath.row]
            cell.mRoomFees.isUserInteractionEnabled = isClickEdit[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (indexPath.section == 0) {
            let deleteButton = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                // write code
    //            Bussiness.manage.mUser.remove(at: indexPath.row)
                API.user.USER_REF.child(Bussiness.manage.mUser[indexPath.row].mRoomId!).removeValue()
    //                Bussiness.manage.mUser[indexPath.row].mRoomId
                Bussiness.manage.removePreviousData()
                Bussiness.manage.ditInit {
                    self.changeData()
                    NotificationCenter.default.post(name: self.nDidAddNewUser, object: nil)
                }
                
                success(true)
            })
            
            deleteButton.backgroundColor = #colorLiteral(red: 1, green: 0.02479779215, blue: 0, alpha: 0.7198112643)

            let editButton = UIContextualAction(style: .normal, title:  "Edit", handler: { [self]  (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                isClickEdit[indexPath.row] = true
                var Index = [IndexPath]()
                Index.append(indexPath)
                tableView.reloadRows(at: Index, with: .right)
                success(true)
            })
            editButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

            return UISwipeActionsConfiguration(actions: [deleteButton, editButton])
        } else {
            let clearButton = UIContextualAction(style: .normal, title:  "Clear", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                // write code
                NotificationCenter.default.post(name: self.nIsClickedClearButton, object: nil)
                success(true)
            })
            clearButton.backgroundColor = #colorLiteral(red: 1, green: 0.02479779215, blue: 0, alpha: 0.7198112643)
            
            let saveButton = UIContextualAction(style: .normal, title:  "Save", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                NotificationCenter.default.post(name: self.nIsClickedSaveButton, object: nil)
                success(true)
            })
            saveButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

            return UISwipeActionsConfiguration(actions: [clearButton, saveButton])
        }
    }
}

extension MePageViewController: InfoUserDelegate {
    
    func isClickDoneButton(_ indexRow: IndexPath, _ mRoomId: UILabel, _ mUsername: UITextField, _ mDateJoined: UITextField, _ FirstDeposit: UITextField, _ mPhoneNumber: UITextField, _ mRoomFees: UITextField) {
        
        isClickEdit[indexRow.row] = false
        
        mUser[indexRow.row] = User.init(username: mUsername.text!, roomId: mRoomId.text!, phoneNumber: mPhoneNumber.text!, firstDeposit: Int(FirstDeposit.text!)!, dateJoined: mDateJoined.text!, roomFees: Int(mRoomFees.text!)!)
        
        if Int(mRoomFees.placeholder!) != Int(mRoomFees.text!)! {
            Bussiness.manage.mRoomFees[indexRow.row] = Int(mRoomFees.text!)!
            NotificationCenter.default.post(name: nIsRoomFeesChange, object: nil)
        }
        
        var Index = [IndexPath]()
        Index.append(indexRow)
        tableView.reloadRows(at: Index, with: .right)
    }
    
}
