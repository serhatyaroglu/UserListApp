//
//  AppDelegate.swift
//  User List App
//
//  Created by serhat yaroglu on 7.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

      func application(
          _ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
          window = UIWindow(frame: UIScreen.main.bounds)
          window?.rootViewController = UserListVC()
          window?.makeKeyAndVisible()
          return true
      }

}


