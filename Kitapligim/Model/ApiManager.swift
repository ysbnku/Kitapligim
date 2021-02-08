//
//  CheapbookApi.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 20.12.2020.
//  Copyright © 2020 Yavuz BİTMEZ. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper



class CheapbookApi {
    
    static let sharedInstance = CheapbookApi()
    private let  apiBaseURL = "https://ysbcheap.herokuapp.com/?key=debug&keyword="
    private let apisecondBaseURL = "http://www.erasmusdeneyimim.com/api/apiyavuz.php?category=books"

    
    func ping(){
        Alamofire.request("https://ysbcheap.herokuapp.com/?key=debug&keyword=").responseString { (response) in
            print("<*> apiLink : Ping atıldı \(response)")
        }
    }
    func fetchBooks(qrCode:String,comletion:@escaping ([Book]) -> Void){
        let apiLink = "\(apiBaseURL)\(qrCode)"
        print("<*> apiLink : \(apiLink)")
        Alamofire.request(apiLink).responseJSON { response in
            let Model :Model = Mapper<Model>().map(JSONObject:response.result.value)!
            switch response.result {
            case .success( _) : comletion(Model.books!)
            case .failure(_) : Helper.noConnectionAlert(url: "fetchBooks")
            }
        }
    }
    func fetchMostSearchedBooks(completion:@escaping (CBResponse) -> Void){
        print("<*> apiLink : \(apisecondBaseURL)")
        Alamofire.request(apisecondBaseURL).responseJSON { response in
            let cbModel:CBModel = Mapper<CBModel>().map(JSONObject:response.result.value)!
            switch response.result {
            case . success(_) : cbModel.data!.response!.forEach { obj in completion(obj) }
            case .failure(_) : Helper.noConnectionAlert(url: "fetchMostSearchedBooks")
            }
        }
    }
    func getmyLibrary(completion:@escaping (CBResponse) -> Void){
        let api = "http://www.erasmusdeneyimim.com/api/library.php?getmylibrary&user_id=2"
        Alamofire.request(api).responseJSON { response in
        let cbModel:CBModel = Mapper<CBModel>().map(JSONObject:response.result.value)!
            switch response.result {
            case .success( _) : cbModel.data!.response!.forEach { obj in completion(obj)}
            case .failure( _) : Helper.noConnectionAlert(url: "getmyLibrary")
            }
        }
    }
    func addBookLibrary(parameters: Parameters,completion:@escaping ([Any]) -> Void){
        let api = "http://www.erasmusdeneyimim.com/api/library.php?addmyLibrary"
        Alamofire.request(api, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success( _) : completion([response])
            case .failure( _) : Helper.noConnectionAlert(url: "addBookLibrary")
            }
        }
    }
    
    func addSearchedBooks(data:[Book],isbn:String,completion:@escaping ([Any]) -> Void){
        let parameters: Parameters = [
            "book_name" : data[0].title! ,
            "book_isbn" : isbn ,
            "book_publisher" : data[0].publisher!,
            "book_author" : data[0].author! ,
            "image" : data[0].img!
            ]
        let api = "http://www.erasmusdeneyimim.com/api/apiyavuz.php?category=addBook"
        Alamofire.request(api, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { success in
            switch success.result {
            case .success( _) : completion([success])
            case .failure( _) : Helper.noConnectionAlert(url: "addSearchedBooks")
            }
        }
    }
}
