//
//  AppDelegate.swift
//  HOME
//
//  Created by TT Nguyen on 1/20/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import Firebase
import ESTabBarController_swift
import UserNotifications
import FirebaseDatabase
import IQKeyboardManagerSwift
import NVActivityIndicatorView


var BASE_URL: DatabaseReference?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let introController = IntroViewController()
        window?.rootViewController = introController
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        BASE_URL = Database.database().reference()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (isSuccess, error) in
            if error != nil {
                print("Alert notify setup unsuccessful")
            } else {
                print("Alert notify setup successful")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

