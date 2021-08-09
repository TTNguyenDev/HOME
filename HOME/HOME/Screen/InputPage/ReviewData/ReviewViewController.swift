//
//  ReviewViewController.swift
//  HOME
//
//  Created by Trọng Tín on 19/03/2021.
//  Copyright © 2021 TT Nguyen. All rights reserved.
//

import UIKit
import SCLAlertView

class ReviewViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let mUser = Bussiness.manage.mUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Review Data"
        let exportButton = UIBarButtonItem(title: "Export All", style: .plain, target: self, action: #selector(confirmSaveDataAlert))
        navigationItem.rightBarButtonItem = exportButton
        _ = Bussiness.manage.getAllPaper()
        setupTableView()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let exportSingleButton = UIContextualAction(style: .normal, title:  "Export Single Room", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // write code
            let file = Date.getCurrent_MonthYearString() + "_" + Bussiness.manage.mUser[indexPath.row].mRoomId! + ".txt"
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let contents = Bussiness.manage.mPaperForEachRoom[indexPath.row]
            do {
                try contents.write(to: dir.appendingPathComponent(file), atomically: false, encoding: .utf8)
            } catch {
                print("Error: \(error)")
            }
            success(true)
        })
        
        exportSingleButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)

        return UISwipeActionsConfiguration(actions: [exportSingleButton])
    }
    
    @objc func confirmSaveDataAlert() {
        //Alert
        let alert = SCLAlertView()
        _ = alert.addButton("To folder") { [self] in
            let folder = Date.getCurrent_MonthYearString()
            let file = "Room"
            
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let directoryURL = dir.appendingPathComponent(folder)
            var fileURL = directoryURL.appendingPathComponent(file + mUser[0].mRoomId! + ".txt")
            var contents = Bussiness.manage.mPaperForEachRoom[0]
            do {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                for i in 0..<self.mUser.count {
                    fileURL = directoryURL.appendingPathComponent(file + mUser[i].mRoomId! + ".txt")
                    contents = Bussiness.manage.mPaperForEachRoom[i]
                    do {
                        try contents.write(to: fileURL, atomically: false, encoding: .utf8)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            catch {
                print("Error: \(error)")
            }
        }
        
        _ = alert.addButton("To File") {
            let file = Date.getCurrent_MonthYearString() + ".txt"
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let contents = Bussiness.manage.getAllPaper()
            do {
                try contents.write(to: dir.appendingPathComponent(file), atomically: false, encoding: .utf8)
            } catch {
                print("Error: \(error)")
            }
        }
        
        _ = alert.showSuccess("Saved to Files App!", subTitle: "File name's: \(Date.getCurrent_MonthYearString()).txt")
    }
    
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CellPageOfEachRoom", bundle: nil), forCellReuseIdentifier: "cellID")
        tableView.rowHeight = 380
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bussiness.manage.mUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CellPageOfEachRoom
        cell.UIText.text = Bussiness.manage.mPaperForEachRoom[indexPath.row]
        return cell
    }
}
