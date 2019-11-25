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
    var mUserData = [UserData]()
    var mPreviousUserData = [UserData]()
    var mTotalOfEachRoom = [Int]()          //*
    var mWaterFeesOfEachRoom = [Int]()      //*
    var mElecFeesOfEachRoom = [Int]()       //*
    var mPaperForEachRoom = [String]()
    var mTotalBalance: Int?
    var mTotalBalanceOfMonth: Int?
    var mRecieved: Int?    //*
    var mTotalFees: Int? //*
    
    let mIsDataDidChanged = Notification.Name(isDataDidChanged)
    
    
    init() {}
    
    func ditInit(completion: @escaping () -> Void) {
        removePreviousData()
        
        var lastMonth = Date.getLastMonth()
        print(lastMonth)
        var currentMonth = Date.getCurrentMonth()
        print(currentMonth)
        
        API.user.checkDataExisted(date: currentMonth, nonExisted: {
            currentMonth = Date.getLastMonth()
            lastMonth = Date.getLastLastMonth()
            
            API.user.observeUserDataWithDate(date: lastMonth) { (previousUserData) in
                self.mPreviousUserData.append(previousUserData)
            }
            
            API.user.observeUserDataWithDate(date: currentMonth) { (userData) in
                self.mUserData.append(userData)
                if self.mUserData.count == 6 {
                    self.calculateWith(previousUserData: self.mPreviousUserData, userData: self.mUserData)
                    self.recievedInit()
                    completion()
                }
            }
        }) {
            
            API.user.observeUserDataWithDate(date: lastMonth) { (previousUserData) in
                self.mPreviousUserData.append(previousUserData)
            }
            
            API.user.observeUserDataWithDate(date: currentMonth) { (userData) in
                self.mUserData.append(userData)
                if self.mUserData.count == 6 {
                    self.calculateWith(previousUserData: self.mPreviousUserData, userData: self.mUserData)
                    self.recievedInit()
                    completion()
                }
            }
        }
    }
    
    func recievedInit() {
        for i in 0..<6 {
            if mUserData[i].mState! {
                mRecieved! += mTotalOfEachRoom[i]
            }
        }
    }
    
    func getRecieved() -> Int {
        return mRecieved!
    }
    
    func removePreviousData() {
        mUserData.removeAll()
        mPreviousUserData.removeAll()
        mWaterFeesOfEachRoom.removeAll()
        mElecFeesOfEachRoom.removeAll()
        mTotalOfEachRoom.removeAll()
        mPaperForEachRoom.removeAll()
        mTotalBalance = 0
        mTotalBalanceOfMonth = 0
        mRecieved = 0
        mTotalFees = 0
    }
    
    func transferRoomID(roomID: String) -> String {
        switch roomID {
        case "p1_1":
            return "phòng 1 tầng 1"
        case "p3_1":
            return "phòng 3 tầng 1"
        case "p1_2":
            return "phòng 1 tầng 2"
        case "p2_2":
            return "phòng 2 tầng 2"
        case "p3_2":
            return "phòng 3 tầng 2"
        case "p4_2":
            return "phòng 4 tầng 2"
        default:
            return "error"
        }
    }
    
    func regconizeUserById(id: String) -> Int {
        switch id {
        case "p1_1":
            return 0
        case "p1_2":
            return 1
        case "p2_2":
            return 2
        case "p3_1":
            return 3
        case "p3_2":
            return 4
        case "p4_2":
            return 5
        default:
            return -1
        }
    }
    
    func reconizeIdByNumber(idNumber: Int) -> String {
        switch idNumber {
        case 0 :
            return "p1_1"
        case 1:
            return "p1_2"
        case 2:
            return "p2_2"
        case 3:
            return "p3_1"
        case 4:
            return "p3_2"
        case 5:
            return "p4_2"
        default:
            return ""
        }
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
            let elecUsed = (userData[i].mElecValue! - previousUserData[i].mElecValue!) * mElecFees
            let waterUsed = (userData[i].mWaterValue! - previousUserData[i].mWaterValue!) * mWaterFees
            let sum = elecUsed + waterUsed + mRoomFees[i] + mOtherFees
            
            mElecFeesOfEachRoom.append(elecUsed)
            mWaterFeesOfEachRoom.append(waterUsed)
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
        for i in 0..<6 {
       
            
        var mTotalOfEachRoomRounded = Int(round(Double(mTotalOfEachRoom[i]) / 1000) * 1000)
//        if mUserData[i].mRoomId == "p2_2" {
//            mTotalOfEachRoomRounded += 70000
//        }
            
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
                        - TỔNG CỘNG: \((mTotalOfEachRoomRounded as NSNumber).transferToCurrency)
                                (Ghi chú: điện: 3500/kW, nước: 5000/khối)
            """
            
//            if mUserData[i].mRoomId == "p2_2" {
//                paperForEachRoom += "\n\t\t - Tiền wifi: 70 000"
//            }
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
