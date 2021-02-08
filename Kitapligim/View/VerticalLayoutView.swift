//
//  VerticalLayoutView.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 1.02.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import Foundation
import UIKit

class VerticalLayoutView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(stackView)
        
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stackView]-|", options: [], metrics: nil, views: ["stackView": stackView]))
        
        let margins = scrollView.layoutMarginsGuide
        stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.layoutMargins = .zero
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let stackView : UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.distribution = .equalSpacing
        v.spacing = 0
        return v
    }()
}
