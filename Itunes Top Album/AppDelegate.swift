//
//  AppDelegate.swift
//  Itunes Top Album
//
//  Created by Dhanasekarapandian Srinivasan on 1/20/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13, *) {
            return true
        }else{
            window = UIWindow()
            let topAlbumsTableViewController = TopAlbumsTableViewController(style: UITableView.Style.grouped)
            let roorNavigationController = UINavigationController(rootViewController: topAlbumsTableViewController)
            window?.rootViewController = roorNavigationController
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func test() {
        let entity = NSEntityDescription.entity(forEntityName: "Country", in: persistentContainer.viewContext)

        let c = Country(entity: entity!, insertInto: persistentContainer.viewContext)
        c.dialingCode = 91
        c.isoCode2 = "IN"
        c.isoCode3 = "INA"
        c.name = "India"
        
        let config = NSEntityDescription.entity(forEntityName: "Config", in: persistentContainer.viewContext)
        let inConf = Config(entity: config!, insertInto: persistentContainer.viewContext)
        inConf.setValue(false, forKey: "enabled")
        inConf.setValue(false, forKey: "featureShow")
        inConf.setValue("IN", forKey: "isoCode2")
        inConf.setValue(false, forKey: "receiveOnly")
        c.config = inConf
        try? persistentContainer.viewContext.save()
    }
    
    func fetch() {
        let r = NSFetchRequest<Country>(entityName: "Country")
        guard let res = try? persistentContainer.viewContext.fetch(r) else { return }
        for item in res {
            print(item.dialingCode)
            print(item.isoCode3 ?? "")
            print(item.isoCode2 ?? "")
            print(item.name ?? "")
        }
        delete()
    }
    
    func delete() {
        let r = NSFetchRequest<Country>(entityName: "Country")
        
               guard let res = try? persistentContainer.viewContext.fetch(r) else { return }
               for item in res {
                persistentContainer.viewContext.delete(item)
               }
        try? persistentContainer.viewContext.save()

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "rss_feed")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

