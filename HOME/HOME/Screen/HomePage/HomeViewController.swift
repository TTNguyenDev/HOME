//
//  HomeViewController.swift
//  HOME
//
//  Created by TT Nguyen on 1/22/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

/*
HOME:
+ Balance(total, month label) -> Load database
+ Daysleft: Gọi hàm local
+ My Process:  hiển thị mRecieved / mTotalBalanceOfMonth
               +(touchUpInside) Hiển thị trạng thái của mỗi phòng, phòng nào xong thì hiện màu green, chưa thì red, slider hiển thị % hoàn thành so với mTotalOfEachRoom.
               + Tích hợp nút edit để sửa lại trạng thái, nếu một user đóng tiền, sẽ có nút hoàn thành, hoặc tuỳ chỉnh(điền số tiền đã đóng, và số tiền còn thiếu)
 
 
*/

import UIKit
import FoldingCell
import NVActivityIndicatorView

class HomeViewController: BaseViewController, NVActivityIndicatorViewable{
    
    @IBOutlet var tableView: UITableView!
    
    enum Const {
        static let closeCellHeight: CGFloat = 150
        static let openCellHeight: CGFloat = 350
        static let rowsCount = 3
    }
    
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupIndicator()
    }
    
    fileprivate func setupIndicator() {
        let size = CGSize(width: 30, height: 30)
        let indicatorType = NVActivityIndicatorType.init(rawValue: 8)
        
        startAnimating(size, message: "Loading...", messageFont: UIFont.boldSystemFont(ofSize: 20), type: indicatorType, color: .red, padding: 2, displayTimeThreshold: 2, minimumDisplayTime: 2, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: .red, fadeInAnimation: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating(nil)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = .white
        
        tableView.register(UINib(nibName: "BalanceFoldingCell", bundle: nil), forCellReuseIdentifier: "BalanceFoldingCell")
        tableView.register(UINib(nibName: "CalendarFoldingCell", bundle: nil), forCellReuseIdentifier: "CalendarFoldingCell")
        tableView.register(UINib(nibName: "StatusFoldingCell", bundle: nil), forCellReuseIdentifier: "StatusFoldingCell")
    }
}



// MARK: - FoldingCellSetup
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return Const.rowsCount
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard case let cell as BalanceFoldingCell = cell else {
                return
            }
            if cellHeights[indexPath.row] == Const.closeCellHeight {
                cell.unfold(false, animated: false, completion: nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
        } else if indexPath.row == 1 {
            guard case let cell as CalendarFoldingCell = cell else {
                return
            }
            if cellHeights[indexPath.row] == Const.closeCellHeight {
                cell.unfold(false, animated: false, completion: nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
        } else {
            guard case let cell as StatusFoldingCell = cell else {
                return
            }
            if cellHeights[indexPath.row] == Const.closeCellHeight {
                cell.unfold(false, animated: false, completion: nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
        }
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceFoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarFoldingCell", for: indexPath) as! FoldingCell
            let durations: [TimeInterval] = [0.26, 0.2, 0.2]
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatusFoldingCell", for: indexPath) as! FoldingCell
            let durations: [TimeInterval] = [0.26, 0.2, 0.2]
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            return cell
        }
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed  && indexPath.row == 0 {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else if cellIsCollapsed  && indexPath.row == 1 {
            cellHeights[indexPath.row] = Const.openCellHeight + 200
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else if cellIsCollapsed  && indexPath.row == 2 {
            cellHeights[indexPath.row] = Const.openCellHeight + 200
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}
