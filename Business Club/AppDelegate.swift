//
//  AppDelegate.swift
//  Business Club
//
//  Created by Jerald Abille on 2/13/19.
//  Copyright © 2019 Jerald Abille. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let companiesViewController = CompaniesViewController()
    let navigationController = UINavigationController(rootViewController: companiesViewController)
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
    
    return true
  }
}

