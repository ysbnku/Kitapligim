//
//  Helper.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 25.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Helper {
    public static let tabbarHeight:CGFloat = 80
    public static let backgroundColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    
    class public func noConnectionAlert(url:String){
        let alert = CustomAlert(title:  """
                        Kitaplar yüklenemedi,
                        Şu anda internet erişimi
                        sağlanamıyor.
                        """)
        print("DP Api error \(url)")
        alert.show(animated: true)
    }
}
