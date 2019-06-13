//
//  AppDelegate.swift
//  Todolist
//
//  Created by ali aghajani on 5/23/19.
//  Copyright © 2019 ali aghajani. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//       print(Realm.Configuration.defaultConfiguration.fileURL)
        
      
        
        do {
            _ =  try Realm()
            
            
        } catch {
            print("error initialising new realm \(error)")
        }
        return true
    }


   
    
}

