//
//  ViewController.swift
//  CheapBook
//
//  Created by Yavuz BİTMEZ on 20.12.2020.
//  Copyright © 2020 Yavuz BİTMEZ. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController,UICollectionViewDelegateFlowLayout {

    public var isbnNo:String = ""
    public var dataList : [Book] = []
    private var collectionView:UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Helper.backgroundColor
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = isbnNo


        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10

        
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - Helper.tabbarHeight), collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor =  Helper.backgroundColor
        self.view.addSubview(collectionView)
        collectionView.register(collectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")


        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            CheapbookApi.sharedInstance.addSearchedBooks(data: self.dataList, isbn: self.isbnNo) { success in }
            
        }
//Aramaları da ekliyor .
        CheapbookApi.sharedInstance.fetchBooks(qrCode: isbnNo) { response in
             self.dataList = response
            self.collectionView.reloadData()
        }
    }
}
//MARK: - CollectionviewDatasource
extension CollectionViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionViewCell
        cell.price.text = self.dataList[indexPath.row].price
        cell.img.sd_imageTransition = .fade
        cell.img.sd_setImage(with: URL(string: self.dataList[indexPath.row].img ?? "Bulamadım"), completed: nil)
        cell.title.text = self.dataList[indexPath.row].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .custom
        detailVC.myInit(book: self.dataList[indexPath.row])
        present(detailVC, animated: true, completion: nil)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width/2 - 15, height: (self.view.frame.size.height/2 - 20))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CollectionViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}


class collectionViewCell : UICollectionViewCell {
    var title = UILabel()
    var img = UIImageView()
    var websiteLogo = UIImageView()
    var price = UILabel()
    var author = UILabel()
    var publisher = UILabel()
    var resource = UILabel()
    var website = UILabel()

    override init(frame: CGRect) {
          super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4

        img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(img)
        
        img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        img.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        img.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -65).isActive = true
        img.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

       
        websiteLogo = UIImageView.init(frame: .zero)
        websiteLogo.contentMode = .scaleToFill
        websiteLogo.translatesAutoresizingMaskIntoConstraints = false
        websiteLogo.image = UIImage(named: "pandora")
        addSubview(self.websiteLogo)

        websiteLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        websiteLogo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        websiteLogo.heightAnchor.constraint(equalToConstant: 5).isActive = true

        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .lightGray
        title.textAlignment = .left
        title.numberOfLines = 2
        title.font = UIFont.OpenSans(.semibold, size: 14)
        contentView.addSubview(title)
        title.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant: -10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 0).isActive = true
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4).isActive = true

        
        price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textColor = .red
        price.textAlignment = .center
        price.font = UIFont.OpenSans(.semibold, size: 17)
        contentView.addSubview(price)
        price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        price.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        


    }
    required init?(coder aDecoder: NSCoder) {

         fatalError("init(coder:) has not been implemented")
     }
}






