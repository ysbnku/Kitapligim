//
//  ScannerViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 19.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Alamofire

class ScannerViewController: UIViewController, QRScannerViewDelegate {

    var scannerView = QRScannerView()
    var backgroundImage = UIImageView()
    let frontEndbg = UIView()
    
    var bookIsbn:String?
    var returnKey:UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Helper.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationItem.title = "Lütfen barkodu okutun"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.scannerView = QRScannerView.init(frame: CGRect(x: 35, y: 150, width: self.view.frame.size.width-70, height: self.view.frame.size.height / 3))
        self.scannerView.delegate = self
        self.scannerView.layer.cornerRadius = 5
        self.scannerView.layer.borderColor = UIColor(red: 83.0/255.0, green: 186.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
        self.scannerView.layer.borderWidth = 2
        

    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if !scannerView.isRunning {
                scannerView.startScanning()
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            if !scannerView.isRunning {
                scannerView.stopScanning()
            }
        }
    override func viewDidAppear(_ animated: Bool) {
        self.backgroundImage.frame = CGRect(x: -140, y: 0, width: self.view.frame.size.width + 280, height: self.view.frame.size.height)
        self.backgroundImage.frame = CGRect(x: -140, y: 0, width: self.view.frame.size.width + 280, height: self.view.frame.size.height)
        self.backgroundImage.image = UIImage(named: "scannerbg")
        self.backgroundImage.contentMode = .scaleAspectFill
        self.backgroundImage.alpha = 0.7
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.scannerView)

        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat ,.autoreverse ], animations: {
            self.backgroundImage.center.x += self.view.bounds.width/3
        }, completion: nil)
    }
    func qrScanningDidStop() {
//        let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
//        scanButton.setTitle(buttonTitle, for: .normal)
    }
    
    func qrScanningDidFail() {
        print("Tekrar Deneyin")
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        var dataArr:[Book]?
        let parameters: Parameters = ["book_isbn":str!,"user_id":"2"]

        if self.returnKey != nil {
            self.dismiss(animated: true) {
                CheapbookApi.sharedInstance.fetchBooks(qrCode: str!) { (responseArray) in
                    dataArr = responseArray
                    CheapbookApi.sharedInstance.addSearchedBooks(data: dataArr!, isbn: str!) { success in }
                    CheapbookApi.sharedInstance.addBookLibrary(parameters: parameters) { (success) in}
                }
                

            }
        }else {
            let vc = CollectionViewController()
            vc.isbnNo = str!
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


