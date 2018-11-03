//
//  Shop.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/9/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class Shop: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var shopCollection: UICollectionView!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController!.title = "فروشگاه"
        
        let shopFlowLayout = UICollectionViewFlowLayout()
        shopFlowLayout.scrollDirection = .vertical
        
        shopCollection = UICollectionView(frame: CGRect(x: view.frame.size.width / 20, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)! , width: view.frame.size.width * 18 / 20, height: view.frame.size.height - (tabBarController?.tabBar.frame.size.height)! - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!), collectionViewLayout: shopFlowLayout)
        shopCollection.register(shopViewCollectionCell.self, forCellWithReuseIdentifier: "shopViewCollectionCell")
        shopCollection.delegate = self
        shopCollection.dataSource = self
        shopCollection.backgroundColor = UIColor.clear
        shopCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        shopCollection.showsVerticalScrollIndicator = false
        shopCollection.showsHorizontalScrollIndicator = false
        view.addSubview(shopCollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Global.allProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopViewCollectionCell", for: indexPath) as! shopViewCollectionCell
        let dict = Global.allProducts[indexPath.row]
        cell.image.image = UIImage(named: Global.productsThumbnails[indexPath.row])
        cell.title.text = dict[0]
        cell.price.text = dict[1]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Global.itemInfo = Global.allProducts[indexPath.row]
        Global.itemImage = UIImage(named: Global.productsImages[indexPath.row])!
        Global.itemThumbnail = UIImage(named: Global.productsThumbnails[indexPath.row])!
        performSegue(withIdentifier: "shopItem", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: shopCollection.frame.size.width / 2 - 20, height: (shopCollection.frame.size.width / 2) * 4 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

class shopViewCollectionCell: UICollectionViewCell {
    
    var image: UIImageView!
    var title: UILabel!
    var price: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        title.text = nil
        price.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        contentView.addSubview(image)
        
        title = UILabel(frame: CGRect(x: 0, y: frame.width * 22 / 30, width: frame.width, height: frame.width / 3))
        title.textColor = UIColor.white
        title.textAlignment = .center
        title.backgroundColor = UIColor.init(white: 0.5, alpha: 0.2)
        title.clipsToBounds = true
        title.layer.cornerRadius = 15
        contentView.addSubview(title)
        
        price = UILabel(frame: CGRect(x: 0, y: frame.width, width: frame.width, height: frame.width / 3))
        price.textColor = UIColor.darkGray
        price.textAlignment = .center
        price.backgroundColor = UIColor.init(white: 0.5, alpha: 0.2)
        price.clipsToBounds = true
        price.layer.cornerRadius = 15
        contentView.addSubview(price)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
