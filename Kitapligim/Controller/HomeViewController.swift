//
//  ViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 20.12.2020.
//  Copyright © 2020 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UISearchBarDelegate{
    
    var logo = UIImageView()
    var searchButton = UIButton()
    var qrcodeButton = UIButton()
    var searchTextfield = UITextField()
    var searchBar = UISearchBar()
    
    var stackView : UIStackView!
    var scrollView : UIScrollView!
        
    private var dataList:[Book] = []
    let arrCategory = ["En Çok Arananlar","Günün En Çok Arananları","Haftanın En Çok Arananları","Haftanın En Çok Arananları","Ayın En Çok Arananları"]

    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = Helper.backgroundColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(named: "setting"), style: .plain, target: self, action: #selector(settingsButton))
        
        searchBar.placeholder = "Aramak istediğiniz kitabı girebilirsiniz"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)

        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        self.scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
       
       

     
        for i in 0..<arrCategory.count-1 {
            let mostSearchedView = MostSearchedView()
            mostSearchedView.frame = CGRect(x: 10, y: 0, width: self.view.frame.size.width, height: 150)
            mostSearchedView.translatesAutoresizingMaskIntoConstraints = false
            mostSearchedView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            mostSearchedView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width).isActive = true
            mostSearchedView.rootVC = self
            mostSearchedView.myInit(text: arrCategory[i])
            self.stackView.addArrangedSubview(mostSearchedView)
            self.scrollView.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, constant: -80).isActive = true
        }
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 0).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 0).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0).isActive = true
        
    }
    @objc func settingsButton(){
        print("Bastım")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let vc = CollectionViewController()
        vc.isbnNo = searchBar.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
