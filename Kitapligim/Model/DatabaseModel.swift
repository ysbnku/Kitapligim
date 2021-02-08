

import Foundation
import ObjectMapper

struct CBModel : Mappable {
    var meta : CBMeta?
    var data : CBData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        meta <- map["meta"]
        data <- map["data"]
    }

}

struct CBMeta : Mappable {
    var status_code : Int?
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status_code <- map["status_code"]
        message <- map["message"]
    }

}

struct CBData : Mappable {
    var success : Bool?
    var response : [CBResponse]?


    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        success <- map["success"]
        response <- map["response"]
    }

}

struct CBResponse : Mappable {
    var ID : Int?
    var count : Int?
    var book_name : String?
    var book_isbn : String?
    var image : String?
    var likecount : Int?
    var author : String?
    var publisher : String?
    var book_id : Int?
    var user_id : Int?
    var date : String?
    var is_sell : Int?
    var price : Int?
    var is_trade : Int?



    


    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        
        ID <- map["id"]
        count <- map["count"]
        book_name <- map["name"]
        book_isbn <- map["isbn"]
        image <- map["image"]
        likecount <- map["likecount"]
        author <- map["author"]
        publisher <- map["publisher"]
        book_id <- map["book_id"]
        user_id <- map["user_id"]
        date <- map["date"]
        is_sell <- map["is_sell"]
        price <- map["price"]
        is_trade <- map["is_trade"]


    }

}

