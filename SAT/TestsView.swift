//
//  TestsView.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/29/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class TestsView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var testsCollection: UICollectionView!
    var testItems = [String]()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        
        testItems.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController!.title = "آزمون ها"
        
        let shopFlowLayout = UICollectionViewFlowLayout()
        shopFlowLayout.scrollDirection = .vertical
        
        testsCollection = UICollectionView(frame: CGRect(x: view.frame.size.width / 20, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)! , width: view.frame.size.width * 18 / 20, height: view.frame.size.height - (tabBarController?.tabBar.frame.size.height)!), collectionViewLayout: shopFlowLayout)
        testsCollection.register(testsCollectionCell.self, forCellWithReuseIdentifier: "testsCollectionCell")
        testsCollection.delegate = self
        testsCollection.dataSource = self
        testsCollection.backgroundColor = UIColor.clear
        testsCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        testsCollection.showsVerticalScrollIndicator = false
        testsCollection.showsHorizontalScrollIndicator = false
        view.addSubview(testsCollection)
        
        for i in 0...12 {
            testItems.append("Item" + String(i))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testsCollectionCell", for: indexPath) as! testsCollectionCell
        
        cell.backgroundColor = UIColor.gray
        
        cell.title.text = testItems[indexPath.row]
        cell.title.clipsToBounds = true
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "test", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: testsCollection.frame.size.width - 20, height: testsCollection.frame.size.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

class testsCollectionCell: UICollectionViewCell {
    
    var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        title.textColor = UIColor.white
        title.textAlignment = .center
        contentView.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
