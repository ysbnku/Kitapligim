//
//  MostSearched.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 19.01.2021.
//  Copyright © 2021 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import SDWebImage


class MostSearchedView: UIView ,UICollectionViewDelegateFlowLayout{

    private var collectionView:UICollectionView?
    private var datalist : [CBResponse] = []
    public var rootVC:UIViewController?
    let identifier = "mostSearchedCell"
    let label = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
    }


    public func getData(){
        CheapbookApi.sharedInstance.fetchMostSearchedBooks { (response) in
            self.datalist.append(response)
            self.collectionView?.reloadData()
        }
    }
    public func myInit(text:String) {
        getData()
        self.label.frame = CGRect.init(x: 10, y: 0, width: self.frame.size.width, height: 30)
        self.label.text = text
        self.label.textColor = .black
        self.addSubview(self.label)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: label.frame.maxY, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: flowLayout)
        self.collectionView?.isScrollEnabled = true
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = .white
        self.collectionView?.isPagingEnabled = true
        self.addSubview(self.collectionView!)
        self.collectionView?.register(mostSearchedCell.self, forCellWithReuseIdentifier: self.identifier)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: CollectionView

extension MostSearchedView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datalist.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = self.datalist[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! mostSearchedCell
        cell.img.sd_imageTransition = .fade
        cell.img.sd_setImage(with: URL(string: obj.image ?? "Bulamadım"), completed: nil)
        cell.title.text = obj.book_name
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = CollectionViewController()
        detailVC.isbnNo = self.datalist[indexPath.row].book_isbn!
        self.rootVC?.navigationController?.pushViewController(detailVC, animated: true)
        
    }

}

class mostSearchedCell : UICollectionViewCell {
    var img = UIImageView()
    var title = UILabel()



    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        contentView.backgroundColor = .white

        img = UIImageView()
        img.frame = CGRect(x: 0, y: 5, width: 100, height: contentView.bounds.height)
        img.contentMode = .scaleAspectFill
        addSubview(self.img)
        addSubview(title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
