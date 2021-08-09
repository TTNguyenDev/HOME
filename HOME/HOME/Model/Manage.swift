//
//  Manage.swift
//  HOME
//
//  Created by TT Nguyen on 1/24/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import Foundation
import FirebaseDatabase

let isDataDidChanged = "co.listener.isDataDidChanged"

class Manage {
    var mUser = [User]()
    var mUserData = [UserData]()
    var mPreviousUserData = [UserData]()
    var mTotalOfEachRoom = [Int]()
    var mWaterFeesOfEachRoom = [Int]()
    var mElecFeesOfEachRoom = [Int]()
    var mPaperForEachRoom = [String]()
    var mTotalBalance: Int?
    var mTotalBalanceOfMonth: Int?
    var mRecieved: Int?
    var mTotalFees: Int?
    var mRoomFees = [Int]()
    var isCurrentMonth = true
    
    let mIsDataDidChanged = Notification.Name(isDataDidChanged)
    
    init() {}
    
    func ditInit(completion: @escaping () -> Void) {
        removePreviousData()
        
        var lastMonth = "06_2021"
        var currentMonth = "07_2021"
        
        API.user.observeUser(completion: { [self] (user) in
            mUser.append(user)
            mRoomFees.append(user.mRoomFees!)
        })
        
        API.user.checkDataExisted(date: currentMonth, nonExisted: { [self] in
            currentMonth = Date.getLastMonth()
            lastMonth = Date.getLastLastMonth()
            isCurrentMonth = false
            getData(lastMonth: lastMonth, currentMonth: currentMonth, completion: {
                completion()
            })
        }) { [self] in

            getData(lastMonth: lastMonth, currentMonth: currentMonth, completion: {
                completion()
            })
        }
    }
    
    func checkStillExist(user: [User], roomID: String) -> Bool {
        for i in 0 ..< user.count {
            if roomID == user[i].mRoomId {
                return true
            }
        }
        return false
    }
    
    func getData(lastMonth: String, currentMonth: String, completion: @escaping () -> Void) {
        API.user.observeUserDataWithDate(date: lastMonth) { [self] (previousUserData) in
            if checkStillExist(user: mUser, roomID: previousUserData.mRoomId!) {
                mPreviousUserData.append(previousUserData)
            }
        }
        
        API.user.observeUserDataWithDate(date: currentMonth) { [self] (userData) in
            if checkStillExist(user: mUser, roomID: userData.mRoomId!) {
                mUserData.append(userData)
            }
            if mUserData.count == mUser.count {
                calculateWith(previousUserData: mPreviousUserData, userData: mUserData)
                recievedInit()
                completion()
            }
        }
    }
    
    func recievedInit() {
        for i in 0..<mUser.count {
            if mUserData[i].mState! {
                mRecieved! += mTotalOfEachRoom[i]
            }
        }
    }
    
    func getRecieved() -> Int {
        return mRecieved!
    }
    
    func removePreviousData() {
        mUser.removeAll()
        mUserData.removeAll()
        mPreviousUserData.removeAll()
        
        mWaterFeesOfEachRoom.removeAll()
        mElecFeesOfEachRoom.removeAll()
        mTotalOfEachRoom.removeAll()
        mPaperForEachRoom.removeAll()
        mRoomFees.removeAll()
        
        mTotalBalance = 0
        mTotalBalanceOfMonth = 0
        mRecieved = 0
        mTotalFees = 0
    }
    // form roomID: Floor_Number
    func transferRoomID(roomID: String) -> String {
        var i = 1, f = 0, n = 0
        while let a = Int(roomID.prefix(i)) {
            i += 1
            f = a
        }
        i = 1
        while let a = Int(roomID.suffix(i)) {
            i += 1
            n = a
        }
        return "tầng " + String(f) + " phòng " + String(n)
    }
    
    func regconizeUserById(id: String) -> Int {
        for i in 0..<mUser.count {
            if id == mUser[i].mRoomId {
                return i
            }
        }
        return -1 // error
    }
    
    func reconizeIdByNumber(idNumber: Int) -> String {
        return mUser[idNumber].mRoomId!
    }
    
    func setUserStateByIdNumber(idNumber: Int) {
        API.user.setStateUserWith(id: reconizeIdByNumber(idNumber: idNumber))
        mUserData[idNumber].mState = true
        mRecieved! += mTotalOfEachRoom[idNumber]
        self.dataChangedValue()
    }
    
    func getUserData() -> [UserData] {
        return mUserData
    }
    
    func dataChangedValue() {
        NotificationCenter.default.post(name: mIsDataDidChanged, object: nil)
    }
    
    func calculateWith(previousUserData: [UserData], userData: [UserData])  {
        for i in 0..<userData.count {
            var sum = 0
            if (userData[i].mElecValue != 0) {
                let elecUsed = (userData[i].mElecValue! - previousUserData[i].mElecValue!) * mElecFees
                let waterUsed = (userData[i].mWaterValue! - previousUserData[i].mWaterValue!) * mWaterFees
                sum = elecUsed + waterUsed + mRoomFees[i] + mOtherFees
                
                mElecFeesOfEachRoom.append(elecUsed)
                mWaterFeesOfEachRoom.append(waterUsed)
            }
            mTotalOfEachRoom.append(sum)
        }
        mTotalBalanceOfMonth = mTotalOfEachRoom.reduce(0, +)
        mTotalFees = mElecFeesOfEachRoom.reduce(0, +) + mWaterFeesOfEachRoom.reduce(0, +)
        
        API.user.saveManageData(totalOfMonth: mTotalBalanceOfMonth!, totalFees: mTotalFees!, recieved: mRecieved!)
        self.dataChangedValue()
        
    }
    
    func getTotalBalanceOfMonth() -> Int {
        return mTotalBalanceOfMonth!
    }
    
    func getTotalFees() -> Int {
        return mTotalFees!
    }
    
    //Cal calculate func before doing anything
    func getTotalOfRoomWithID(id: String) -> Int {
        return mTotalOfEachRoom[regconizeUserById(id: id)]
    }

    func getTotalOfEachRoom() -> [Int] {
        return mTotalOfEachRoom
    }
    func getPaperOfRoomWithID(id: String) -> String {
        return mPaperForEachRoom[regconizeUserById(id: id)]
    }
    
    func getAllPaper() -> String {
        var paper = ""
        for i in 0..<mPreviousUserData.count {
            var mTotalOfEachRoomRounded = Int(round(Double(mTotalOfEachRoom[i]) / 1000) * 1000)
            if mUserData[i].mWifi! {
                mTotalOfEachRoomRounded += 70000
            }
                
            var paperForEachRoom = """

                                        Phiếu thu tiền \(transferRoomID(roomID: mUserData[i].mRoomId!))
                                         ---------- @@ ----------
            
                        - Tiền phòng: \(mRoomFees[i])
                        - Điện:
                            + Tháng này: \(mUserData[i].mElecValue!)
                            + Tháng trước: \(mPreviousUserData[i].mElecValue!)
                            + Tiêu thụ: \(mUserData[i].mElecValue! - mPreviousUserData[i].mElecValue!) x \(mElecFees) = \(mElecFeesOfEachRoom[i])
            
                        - Nước:
                            + Tháng này: \(mUserData[i].mWaterValue!)
                            + Tháng trước: \(mPreviousUserData[i].mWaterValue!)
                            + Tiêu thụ: \(mUserData[i].mWaterValue! - mPreviousUserData[i].mWaterValue!) x \(mWaterFees) = \(mWaterFeesOfEachRoom[i])
            
                        - Tiền rác: \(mOtherFees)
            """
            if mUserData[i].mWifi! {
                paperForEachRoom += "\n            - Tiền wifi: 70 000"
            }
            paperForEachRoom += """
            \n            - TỔNG CỘNG: \((mTotalOfEachRoomRounded as NSNumber).transferToCurrency)
                                (Ghi chú: điện: 3500/kW, nước: 5000/khối)

            """
            mPaperForEachRoom.append(paperForEachRoom)
            paper += paperForEachRoom
        }
        return paper
    }
}


extension Manage {
    static func transformManage(dictionary: NSDictionary) -> Manage {
        let manage = Manage()
        manage.mTotalBalanceOfMonth = dictionary["mTotalBalanceOfMonth"] as? Int
        manage.mTotalFees = dictionary["mTotalFees"] as? Int
        manage.mRecieved = dictionary["mRecieved"] as? Int
        print(dictionary["mRecieved"] as! Int)
        return manage
    }
}
