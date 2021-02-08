//
//  Model.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 20.12.2020.
//  Copyright © 2020 Yavuz BİTMEZ. All rights reserved.
//
import Foundation
import ObjectMapper

//MARK: Heroku API #START

struct Model: Mappable {
    var books : [Book]?
    
    init?(map:Map) {
}
mutating func mapping(map: Map) {
    books <- map["books"]
    
    }
}


struct Book: Mappable {
    var title: String?
    var author:String?
    var price:String?
    var url:String?
    var img:String?
    var resource:String?
    var publisher:String?
    var pricefloat:Float?
    
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {

        title <- map["title"]
        author <- map["author"]
        price <- map["price"]
        url <- map["website"]
        img <- map["img"]
        resource <- map["resource"]
        publisher <- map["publisher"]
        pricefloat <- map["pricefloat"]
     }
}

//MARK: Heroku API #END

