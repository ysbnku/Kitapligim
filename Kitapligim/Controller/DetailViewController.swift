//
//  DetailViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 27.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private var author = ""
    private var publisher = ""
    private var resource = ""
    private var url = ""
    
    private let authorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let resourceLabel = UILabel()
    private let websiteButton = UIButton()
    private let dismissButton = UIButton()
    
    public func myInit(book:Book){
        self.author = book.author ?? "Bulunamadı"
        self.publisher = book.publisher ?? "Bulunamadı"
        self.resource = book.resource ?? "Bulunamadı"
        self.url = book.url ?? "Bulunamadı"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.popViewController(animated: true)
        self.view.layer.cornerRadius = 20
        self.view.backgroundColor = .lightGray
        let width = self.view.frame.size.width
        authorLabel.frame = CGRect(x: 20, y: 20, width: width - 40, height: 20)
        authorLabel.font = UIFont.OpenSans(.semibold, size: 15)
        authorLabel.textColor = .black
        authorLabel.text = "Yazar : \(self.author)"
        view.addSubview(authorLabel)
        publisherLabel.frame = CGRect(x: 20, y: 45, width: width - 40, height: 20)
        publisherLabel.font = UIFont.OpenSans(.semibold, size: 15)
        publisherLabel.textColor = .black
        publisherLabel.text = "Yayıncı : \(self.publisher)"
        view.addSubview(publisherLabel)
        resourceLabel.frame = CGRect(x: 20, y: 70, width: width - 40, height: 20)
        resourceLabel.textColor = .black
        resourceLabel.font = UIFont.OpenSans(.semibold, size: 15)
        resourceLabel.text = "Kaynak : \(self.resource)"
        view.addSubview(resourceLabel)
        websiteButton.frame = CGRect(x: 20, y: 95, width: width - 40, height: 40)
        websiteButton.backgroundColor = .red
        websiteButton.layer.cornerRadius = 10
        websiteButton.addTarget(self, action: #selector(websiteBtnAction), for: .touchUpInside)
        websiteButton.setTitle("Siteye Git", for: .normal)
        view.addSubview(websiteButton)
        dismissButton.frame = CGRect(x: width - 40 , y: 20, width: 20, height: 20)
        dismissButton.setImage(UIImage(named: "close"), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissBtnAction), for: .touchUpInside)
        view.addSubview(dismissButton)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @objc func websiteBtnAction(){
        print("basıyorum")
        print(self.url)
        if let url = URL(string: self.url) {
            UIApplication.shared.openURL(url)
        }
    }
    @objc func dismissBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }

            return CGRect(x: 0, y: theView.bounds.height - 140, width: theView.bounds.width, height: theView.bounds.height/3)
        }
    }
}
