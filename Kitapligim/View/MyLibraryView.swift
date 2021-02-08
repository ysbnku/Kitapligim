//
//  MyLibraryView.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 29.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import SDWebImage

class MyLibraryView: UIView {

    let tableView = UITableView()
    var dataList: [CBResponse] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Helper.backgroundColor
        tableView.frame = CGRect(x: 20, y: 20, width: frame.width - 40, height: frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Helper.backgroundColor
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 170
        tableView.register(mylibraryCell.self, forCellReuseIdentifier: "mylibraryCell")
        addSubview(tableView)
        getApi(user_id: "22")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getApi(user_id:String?){
        CheapbookApi.sharedInstance.getmyLibrary { (response) in
            self.dataList.append(response)
            self.tableView.reloadData()
        }
    }
}

extension MyLibraryView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mylibraryCell") as! mylibraryCell
        let obj = self.dataList[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(obj: obj)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(170)
    }
    
    
}
class mylibraryCell:UITableViewCell {
    let imagebook = UIImageView()
    var title = UILabel()
    var author = UILabel()
    var publisher = UILabel()
    let isbn = UILabel()
    let sellimg = UIImageView()
    let trade = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        imagebook.frame = CGRect(x: 15, y: 5, width: 100, height: 150)
        addSubview(imagebook)
        title.frame = CGRect(x: imagebook.frame.maxX + 20, y: 5, width: frame.width - 120, height: 30)
        title.text = "Tutunamayanlar"
        title.font = UIFont.OpenSans(.semibold, size: 15)
        title.textColor = .black
        addSubview(title)
        
        author.frame = CGRect(x: imagebook.frame.maxX + 20, y: title.frame.maxY + 5, width: frame.width - 120, height: 30)
        author.text = "Oguz Atay"
        author.font = UIFont.OpenSans(.semibold, size: 13)
        author.textColor = .black
        addSubview(author)
        
        publisher.frame = CGRect(x: imagebook.frame.maxX + 20, y: author.frame.maxY + 5, width: frame.width - 120, height: 30)
        publisher.text = "Oda Kitap"
        publisher.font = UIFont.OpenSans(.semibold, size: 13)
        publisher.textColor = .black
        addSubview(publisher)

        isbn.frame = CGRect(x: imagebook.frame.maxX + 20, y: publisher.frame.maxY + 5, width: frame.width - 120, height: 30)
        isbn.text = "1231231231"
        isbn.font = UIFont.OpenSans(.semibold, size: 13)
        isbn.textColor = .black
        addSubview(isbn)

        
        sellimg.frame = CGRect(x: frame.width, y: title.frame.midY, width: 30, height: 30)
        sellimg.image = UIImage(named: "sell")?.withRenderingMode(.alwaysTemplate)
        sellimg.tintColor = .black
        addSubview(sellimg)
        trade.frame = CGRect(x: frame.width, y: publisher.frame.midY, width: 30, height: 30)
        trade.image = UIImage(named: "trade")?.withRenderingMode(.alwaysTemplate)
        trade.tintColor = .black
        addSubview(trade)
        
    }
    
    func configure(obj:CBResponse){
        title.text = obj.book_name
        author.text = obj.author
        publisher.text = obj.publisher
        isbn.text = obj.book_isbn
        imagebook.sd_imageTransition = .fade
        imagebook.sd_setImage(with: URL(string: obj.image ?? "https://i.dr.com.tr/cache/200x200-0/originals/0000000189315-1.jpg"), completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
