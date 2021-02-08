//
//  UserControl.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 29.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit

class UserLoginValidateView: UIView {
    let label = UILabel()
    let content = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = CGRect(x: 0, y: 0 , width: frame.width , height: frame.height)
        label.textAlignment = .center
        label.center = self.center
        label.numberOfLines = 3
        label.font = UIFont.OpenSans(.semibold, size: 20)
        label.text = "Bu özelliği kullanabilmeniz için \n giriş yapmanız lazım"
        addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
