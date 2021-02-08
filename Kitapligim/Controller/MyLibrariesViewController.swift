//
//  MyLibrariesViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 19.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class MyLibrariesViewController: UIViewController {
    var userloginValidateView:UserLoginValidateView!
    var mylibraryView:MyLibraryView!
    var myqrScanner:QRScannerView!
    var addbooktoLibraryButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Helper.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationItem.title = "Kitaplığım"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        if #available(iOS 13.0, *) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addBookNavItem))
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
//        userloginValidateView = UserLoginValidateView.init(frame: self.view.frame)
//        view.addSubview(userloginValidateView!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let libframe = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 80)
        mylibraryView = MyLibraryView.init(frame: libframe)
        view.addSubview(mylibraryView)

    }

    @objc func addBookNavItem() {
        let scanner = ScannerViewController()
        scanner.returnKey = MyLibrariesViewController()
        present(scanner, animated: true, completion: nil)
        
    }

}
