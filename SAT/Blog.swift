//
//  Blog.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/7/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class Blog: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var blogCollection: UICollectionView!
    
    var segmentedControl = UISegmentedControl()
    var selectedSegment: Int = 0

    var filterButton = UIButton()
    var filterView = UIView()
    
    var typeCollection: UICollectionView!
    var countryCollection: UICollectionView!
    
    var postType = ["SAT", "LSAT", "Toffel", "IELTS", "Dutch"]
    var countryNames = ["brazil", "china", "egypt", "france", "germany", "india", "indonesia", "italy", "malaysia", "poland", "portugal", "romania", "russia", "serbia", "spain", "sweden", "taiwan", "turkey", "usa", "vietnam"]
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        let filterSubViews = self.filterView.subviews
        for subView in filterSubViews {
            subView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController!.title = "بلاگ"
        
        let collectionViewHeight = view.frame.size.height - (navigationController?.navigationBar.frame.size.height)! - (tabBarController?.tabBar.frame.size.height)!

        let blogFlowLayout = UICollectionViewFlowLayout()
        blogFlowLayout.scrollDirection = .vertical
        
        blogCollection = UICollectionView(frame: CGRect(x: view.frame.size.width / 20, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)! , width: view.frame.size.width * 18 / 20, height: view.frame.size.height - (tabBarController?.tabBar.frame.size.height)! - (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)! - 120), collectionViewLayout: blogFlowLayout)
        blogCollection.register(blogViewCollectionCell.self, forCellWithReuseIdentifier: "blogViewCollectionCell")
        blogCollection.delegate = self
        blogCollection.dataSource = self
        blogCollection.backgroundColor = UIColor.clear
        blogCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        blogCollection.showsVerticalScrollIndicator = false
        blogCollection.showsHorizontalScrollIndicator = false
        view.addSubview(blogCollection)
        
        self.filterView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.size.height - (self.tabBarController?.tabBar.frame.size.height)! - 40)
        filterView.backgroundColor = UIColor(hex: "f2f2f2")
        view.addSubview(filterView)
        
        let items = ["موضوع", "کشور"]
        self.segmentedControl = UISegmentedControl(items: items)
        self.segmentedControl.selectedSegmentIndex = self.selectedSegment
        self.segmentedControl.tintColor = .clear
        self.segmentedControl.backgroundColor = UIColor.blue
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)], for: .normal)
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)], for: .selected)
        self.segmentedControl.frame = CGRect(x: self.filterView.frame.size.width / 4, y: (self.navigationController?.navigationBar.frame.size.height)! + 10, width: self.filterView.frame.size.width / 2, height: self.filterView.frame.size.height / 16)
        self.segmentedControl.addTarget(self, action: #selector(self.segmentedControlAction(_:)), for: .valueChanged)
        self.segmentedControl.layer.masksToBounds = true
        self.segmentedControl.layer.cornerRadius = 10
        self.filterView.addSubview(self.segmentedControl)
        
        let typeFlowLayout = UICollectionViewFlowLayout()
        typeFlowLayout.scrollDirection = .vertical
        
        self.typeCollection = UICollectionView(frame: CGRect(x: self.filterView.frame.size.width / 20, y: self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height + 20 , width: self.filterView.frame.size.width * 18 / 20, height: collectionViewHeight - self.segmentedControl.frame.size.height - 70), collectionViewLayout: typeFlowLayout)
        self.typeCollection.delegate = self
        self.typeCollection.dataSource = self
        self.typeCollection.backgroundColor = UIColor.clear
        self.typeCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        self.typeCollection.showsVerticalScrollIndicator = false
        self.typeCollection.showsHorizontalScrollIndicator = false
        self.filterView.addSubview(self.typeCollection)
        self.typeCollection.register(typeCollectionCell.self, forCellWithReuseIdentifier: "typeCollectionCell")
        
        let countryFlowLayout = UICollectionViewFlowLayout()
        countryFlowLayout.scrollDirection = .vertical
        
        self.countryCollection = UICollectionView(frame: CGRect(x: self.filterView.frame.size.width / 20, y: self.segmentedControl.frame.origin.y + self.segmentedControl.frame.size.height + 20 , width: self.filterView.frame.size.width * 18 / 20, height: collectionViewHeight - self.segmentedControl.frame.size.height - 70), collectionViewLayout: countryFlowLayout)
        self.countryCollection.delegate = self
        self.countryCollection.dataSource = self
        self.countryCollection.backgroundColor = UIColor.clear
        self.countryCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        self.countryCollection.showsVerticalScrollIndicator = false
        self.countryCollection.showsHorizontalScrollIndicator = false
        self.filterView.addSubview(self.countryCollection)
        self.countryCollection.register(countryCollectionCell.self, forCellWithReuseIdentifier: "countryCollectionCell")

        self.typeFilter()
        
        filterButton.frame = CGRect(x: 0, y: view.frame.size.height - (tabBarController?.tabBar.frame.size.height)! - 40, width: view.frame.size.width, height: 40)
        filterButton.backgroundColor = UIColor(hex: "f2f2f2")
        filterButton.setTitle("فیلتر", for: .normal)
        filterButton.setTitleColor(UIColor.darkGray, for: .normal)
        filterButton.addTarget(self, action: #selector(filter), for: .touchUpInside)
        view.addSubview(filterButton)
    }
    
    @objc func filter() {
        blogCollection.isHidden = true
        if blogCollection.isHidden {
            filterButton.isHidden = true
            UIView.animate(withDuration: 0.2) {
                self.filterView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.width, height: self.view.frame.size.height - (self.tabBarController?.tabBar.frame.size.height)! - 40)
                self.tabBarController!.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.closeFilter)), animated: true)
            }
        }
    }
    
    @objc func closeFilter() {
        blogCollection.isHidden = false
        if !blogCollection.isHidden {
            filterButton.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.filterView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.size.height - (self.tabBarController?.tabBar.frame.size.height)! - 40)
                self.tabBarController!.navigationItem.rightBarButtonItem = nil
            }
        }
    }

    @objc func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            typeFilter()
            break
        case 1:
            countryFilter()
            break
        default:
            typeFilter()
            break
        }
    }
    
    func typeFilter() {
        typeCollection.isHidden = false
        countryCollection.isHidden = true
    }
    
    func countryFilter() {
        typeCollection.isHidden = true
        countryCollection.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if blogCollection == collectionView {
            return Global.allPosts.count
        } else if typeCollection == collectionView {
            return postType.count
        } else {
            return countryNames.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if blogCollection == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "blogViewCollectionCell", for: indexPath) as! blogViewCollectionCell
            let dict = Global.allPosts[indexPath.row]
            cell.image.image = UIImage(named: Global.postsThumbnails[indexPath.row])
            cell.title.text = dict[0]
            cell.image.layer.cornerRadius = 15
            cell.title.clipsToBounds = true
            cell.title.layer.cornerRadius = 15
            
            return cell
        } else if typeCollection == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCollectionCell", for: indexPath) as! typeCollectionCell
            
            cell.title.text = postType[indexPath.row]
            
            cell.title.clipsToBounds = true
            cell.title.layer.cornerRadius = 15
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCollectionCell", for: indexPath) as! countryCollectionCell
            
            cell.image.image = UIImage(named: countryNames[indexPath.row])
            cell.image.contentMode = .scaleAspectFill
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if blogCollection == collectionView {
            Global.itemInfo = Global.allPosts[indexPath.row]
            Global.itemImage = UIImage(named: Global.postsImages[indexPath.row])!
            performSegue(withIdentifier: "post", sender: self)
        } else if typeCollection == collectionView {
            closeFilter()
        } else {
            closeFilter()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if blogCollection == collectionView {
            return CGSize(width: blogCollection.frame.size.width / 2 - 20, height: blogCollection.frame.size.width / 2)
        } else if typeCollection == collectionView {
            return CGSize(width: typeCollection.frame.size.width - 20, height: 60)
        } else {
            return CGSize(width: 80, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

class blogViewCollectionCell: UICollectionViewCell {
    
    var image: UIImageView!
    var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        title.text = nil
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class typeCollectionCell: UICollectionViewCell {
    
    var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        title.textColor = UIColor.white
        title.backgroundColor = UIColor.brown
        title.textAlignment = .center
        contentView.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class countryCollectionCell: UICollectionViewCell {
    
    var image: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        contentView.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
