//
//  MainTabBarController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 19.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .white
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let tab1:UIImage = UIImage(named: "tab1")!.withRenderingMode(.alwaysTemplate)
        let tab1Selected:UIImage = UIImage(named: "tab1")!.withRenderingMode(.alwaysTemplate)
        let homeTabBarItem:UITabBarItem = UITabBarItem(title: "Ana Sayfa", image: tab1, selectedImage: tab1Selected)
        homeViewController.tabBarItem = homeTabBarItem

        let scannerViewController = UINavigationController(rootViewController: ScannerViewController())
        let tab2:UIImage = UIImage(named: "tab3")!.withRenderingMode(.alwaysTemplate)
        let tab2Selected:UIImage = UIImage(named: "tab3")!
        let scannerTabBarItem:UITabBarItem = UITabBarItem(title: "Barkod Okut", image: tab2, selectedImage: tab2Selected)
        scannerViewController.tabBarItem = scannerTabBarItem
        
        let myLibrariesViewController = UINavigationController(rootViewController: MyLibrariesViewController())
        let tab3:UIImage = UIImage(named: "tab2")!.withRenderingMode(.alwaysTemplate)
        let tab3Selected:UIImage = UIImage(named: "tab2")!.withRenderingMode(.alwaysTemplate)
        let myLibrariesTabBarItem:UITabBarItem = UITabBarItem(title: "Kitaplığım", image: tab3, selectedImage: tab3Selected)
        myLibrariesViewController.tabBarItem = myLibrariesTabBarItem

        let profileViewController = UINavigationController(rootViewController: LogInViewController())
        let tab4:UIImage = UIImage(named: "tab4")!.withRenderingMode(.alwaysTemplate)
        let tab4Selected:UIImage = UIImage(named: "tab4")!.withRenderingMode(.alwaysTemplate)
        let profilTabBarItem:UITabBarItem = UITabBarItem(title: "Profil", image: tab4, selectedImage: tab4Selected)
        profileViewController.tabBarItem = profilTabBarItem
        
        let nearmeViewController = UINavigationController(rootViewController: NearmeViewController())
        let tab5:UIImage = UIImage(named: "tab5")!.withRenderingMode(.alwaysTemplate)
        let tab5Selected:UIImage = UIImage(named: "tab5")!.withRenderingMode(.alwaysTemplate)
        let nearmeTabBarItem:UITabBarItem = UITabBarItem(title: "Yakınımdakiler", image: tab5, selectedImage: tab5Selected)
        nearmeViewController.tabBarItem = nearmeTabBarItem

        

        let tabBarList = [homeViewController, myLibrariesViewController,scannerViewController,profileViewController,nearmeViewController]

        viewControllers = tabBarList    }
    
}
