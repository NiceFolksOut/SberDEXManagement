//
//  AppDelegate.swift
//  SberDEXManagement
//
//  Created by Timofey on 2/17/18.
//  Copyright © 2018 NFO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let user = SimpleUser()
        let rootController = UINavigationController(rootViewController: UserWalletViewController(with: user))
        rootController.view.backgroundColor = .white
        rootController.navigationBar.backgroundColor = .clear
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
        return true
    }

}

