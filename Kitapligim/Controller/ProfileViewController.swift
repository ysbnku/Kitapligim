//
//  ProfileViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 19.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private var tableview:UITableView?
    private var verticalLayoutView:VerticalLayoutView!
    private var segmentType:UISegmentedControl!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = Helper.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.verticalLayoutView = VerticalLayoutView()
        self.verticalLayoutView!.translatesAutoresizingMaskIntoConstraints = false
        self.verticalLayoutView!.backgroundColor = .white
        self.verticalLayoutView!.stackView.distribution = .fill
        self.verticalLayoutView!.stackView.alignment = .center
        self.verticalLayoutView!.stackView.axis = .vertical
        self.verticalLayoutView!.stackView.spacing = 10
        self.view.addSubview(self.verticalLayoutView!)
        
        self.verticalLayoutView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.verticalLayoutView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.verticalLayoutView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.verticalLayoutView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.verticalLayoutView?.stackView.addArrangedSubview(headerView)
        
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 5, y: 5, width: 90, height: 90)
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        headerView.addSubview(imageView)
        
        let fullname = UILabel()
        fullname.frame = CGRect.init(x: 100, y: 10, width: self.view.frame.size.width - 100, height: 32)
        fullname.text = "Yavuz Bitmez"
        fullname.font = UIFont.OpenSans(.bold, size: 19)
        fullname.textColor = .black
        fullname.sizeToFit()
        headerView.addSubview(fullname)
        
        let eposta = UILabel()
        eposta.frame = CGRect.init(x: 100, y: 42, width: self.view.frame.size.width - 100, height: 22)
        eposta.text = "yavuzbitmez.nku@gmail.com"
        eposta.font = UIFont.OpenSans(.regular, size: 15)
        eposta.textColor = .black
        eposta.sizeToFit()
        headerView.addSubview(eposta)
        
        let items = ["Mesajlarım","Bildirimler"]
        self.segmentType = UISegmentedControl(items: items)
        self.segmentType.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            self.segmentType.selectedSegmentTintColor = .black
            } else {
                   // Fallback on earlier versions
            }
        let font = UIFont.systemFont(ofSize: 10)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white ]
        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.segmentType.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        self.segmentType.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        self.segmentType.setTitleTextAttributes(titleTextAttributes2 as [NSAttributedString.Key : Any], for: .normal)
        self.segmentType.layer.cornerRadius = 5
        self.segmentType.addTarget(self, action: #selector(subsTransaction), for: .valueChanged)
        self.segmentType.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
        self.segmentType.heightAnchor.constraint(equalToConstant: self.view.frame.size.height * 0.15/2).isActive = true
        self.verticalLayoutView?.stackView.addArrangedSubview(self.segmentType)

    }
    
    @objc func subsTransaction(sender: UISegmentedControl) {
     print("asdadasda")
    }
}
