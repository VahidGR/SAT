//
//  Home.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/6/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

struct Global {
    static var productInfo = [[String]]()
    static var cardImages = [UIImage]()
    static var itemInfo = [String]()
    static var itemImage = UIImage()
    static var itemThumbnail = UIImage()
    static var allProducts = [["کتاب آزمون 1", "20,000"], ["کتاب آزمون 2", "15,000"], ["کتاب آزمون 3", "20,000"], ["کتاب آزمون 4", "15,000"]]
    static var productsImages = ["1", "2", "1", "2"]
    static var productsThumbnails = ["1th", "2th", "1th", "2th"]
    static var allPosts = [["پست بلاگ 1"], ["پست بلاگ 2"], ["پست بلاگ 3"]]
    static var postsImages = ["p1", "p2", "p3"]
    static var postsThumbnails = ["p1th", "p2th", "p3th"]
    static var firstTime = true // for tests
    static var testTitle = String()
    static var profilePicture = UIImage()
    static var profileName = String()
    static var educationIndex = Int()
}

class Home: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var slider = UIView()
    var image1 = UIImageView()
    var image2 = UIImageView()
    var image3 = UIImageView()
    
    var sliderTimer: Timer!
    
    var scrollView: UIScrollView!
    var shopCollection: UICollectionView!
    var blogCollection: UICollectionView!
    var shopView = UIView()
    var blogView = UIView()

    let shopFlowLayout = UICollectionViewFlowLayout()
    let blogFlowLayout = UICollectionViewFlowLayout()
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.scrollView.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        let shopSubViews = self.shopView.subviews
        for subView in shopSubViews {
            subView.removeFromSuperview()
        }
        let blogSubViews = self.blogView.subviews
        for subView in blogSubViews {
            subView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController!.title = "آزمون گیر"

        scrollView = UIScrollView(frame: CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)! - (tabBarController?.tabBar.frame.size.height)!))
        view.addSubview(scrollView)
        
        slider.frame = CGRect(x: scrollView.frame.size.width / 20, y: 10, width: scrollView.frame.size.width * 18 / 20, height: (scrollView.frame.size.width * 18 / 20) * 9 / 16)
        
        image1.frame = CGRect(x: 0, y: 0, width: slider.frame.size.width, height: slider.frame.size.height)
        image2.frame = CGRect(x: slider.frame.size.width + 10, y: 0, width: slider.frame.size.width, height: slider.frame.size.height)
        image3.frame = CGRect(x: slider.frame.size.width * 2 + 20, y: 0, width: slider.frame.size.width, height: slider.frame.size.height)
        
        image1.image = UIImage(named: "1")
        image2.image = UIImage(named: "2")
        image3.image = UIImage(named: "p3")

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        slider.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        slider.addGestureRecognizer(swipeRight)
        
        slider.addSubview(image1)
        slider.addSubview(image2)
        slider.addSubview(image3)
        
        image1.layer.masksToBounds = true
        image2.layer.masksToBounds = true
        image3.layer.masksToBounds = true

        image1.layer.cornerRadius = 15
        image2.layer.cornerRadius = 15
        image3.layer.cornerRadius = 15
        
        scrollView.addSubview(slider)
        
        shopView.frame = CGRect(x: scrollView.frame.size.width / 20, y: slider.frame.origin.y + slider.frame.size.height + 30, width: scrollView.frame.size.width * 18 / 20, height: 250)
        shopView.backgroundColor = UIColor(hex: "f2f2f2")
        shopView.layer.cornerRadius = 15
        
        let shopLabel = UILabel(frame: CGRect(x: shopView.frame.size.width / 2, y: 0, width: shopView.frame.size.width / 2 - 10, height: 50))
        shopLabel.text = "فروشگاه"
        shopLabel.textAlignment = .right
        shopLabel.textColor = UIColor.darkGray
        shopView.addSubview(shopLabel)
        
        let shopAll = UIButton(frame: CGRect(x: 0, y: 0, width: shopView.frame.size.width / 4, height: 50))
        shopAll.setTitle("همه >", for: .normal)
        shopAll.setTitleColor(UIColor.darkGray, for: .normal)
        shopAll.addTarget(self, action: #selector(allShop), for: .touchUpInside)
        shopView.addSubview(shopAll)

        shopFlowLayout.scrollDirection = .horizontal

        shopCollection = UICollectionView(frame: CGRect(x: 0, y: 50, width: shopView.frame.size.width, height: 200), collectionViewLayout: shopFlowLayout)
        shopCollection.register(shopCollectionCell.self, forCellWithReuseIdentifier: "shopCollectionCell")
        shopCollection.delegate = self
        shopCollection.dataSource = self
        shopCollection.backgroundColor = UIColor.clear
        shopCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        shopCollection.showsVerticalScrollIndicator = false
        shopCollection.showsHorizontalScrollIndicator = false
        shopView.addSubview(shopCollection)
        
        blogView.frame = CGRect(x: scrollView.frame.size.width / 20, y: slider.frame.origin.y + slider.frame.size.height + 300 , width: scrollView.frame.size.width * 18 / 20, height: 250)
        blogView.backgroundColor = UIColor(hex: "f2f2f2")
        blogView.layer.cornerRadius = 15
        
        let blogLabel = UILabel(frame: CGRect(x: blogView.frame.size.width / 2, y: 0, width: blogView.frame.size.width / 2 - 10, height: 50))
        blogLabel.text = "بلاگ"
        blogLabel.textAlignment = .right
        blogLabel.textColor = UIColor.darkGray
        blogView.addSubview(blogLabel)
        
        let blogAll = UIButton(frame: CGRect(x: 0, y: 0, width: blogView.frame.size.width / 4, height: 50))
        blogAll.setTitle("همه >", for: .normal)
        blogAll.setTitleColor(UIColor.darkGray, for: .normal)
        blogAll.addTarget(self, action: #selector(allBlog), for: .touchUpInside)
        blogView.addSubview(blogAll)

        blogFlowLayout.scrollDirection = .horizontal

        blogCollection = UICollectionView(frame: CGRect(x: 0, y: 50, width: blogView.frame.size.width, height: 200), collectionViewLayout: blogFlowLayout)
        blogCollection.register(blogCollectionCell.self, forCellWithReuseIdentifier: "blogCollectionCell")
        blogCollection.delegate = self
        blogCollection.dataSource = self
        blogCollection.backgroundColor = UIColor.clear
        blogCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        blogCollection.showsVerticalScrollIndicator = false
        blogCollection.showsHorizontalScrollIndicator = false
        blogView.addSubview(blogCollection)
        
        scrollView.addSubview(shopView)
        scrollView.addSubview(blogView)

        scrollView.contentSize.height = blogView.frame.origin.y + 300
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ChangeSlide), userInfo: nil, repeats: true)
    }
    
    @objc func allShop() {
        tabBarController?.selectedIndex = 3
    }
    
    @objc func allBlog() {
        tabBarController?.selectedIndex = 2
    }

    @objc func handleGesture(sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizer.Direction.right {
            UIView.animate(withDuration: 0.5) {
                if self.image1.frame.origin.x < 0 {
                    self.image1.frame.origin.x += self.slider.frame.size.width + 10
                    self.image2.frame.origin.x += self.slider.frame.size.width + 10
                    self.image3.frame.origin.x += self.slider.frame.size.width + 10
                }
            }
        }
        else if sender.direction == UISwipeGestureRecognizer.Direction.left {
            UIView.animate(withDuration: 0.5) {
                if self.image3.frame.origin.x > self.slider.frame.origin.x / 3 {
                    self.image1.frame.origin.x -= self.slider.frame.size.width + 10
                    self.image2.frame.origin.x -= self.slider.frame.size.width + 10
                    self.image3.frame.origin.x -= self.slider.frame.size.width + 10
                } else {
                    self.image1.frame = CGRect(x: 0, y: 0, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
                    self.image2.frame = CGRect(x: self.slider.frame.size.width + 10, y: 0, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
                    self.image3.frame = CGRect(x: self.slider.frame.size.width * 2 + 20, y: 0, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
                }
            }
        }
    }
    
    @objc func ChangeSlide() {
        UIView.animate(withDuration: 0.5) {
            if self.image3.frame.origin.x > self.slider.frame.origin.x / 3 {
                self.image1.frame.origin.x -= self.slider.frame.size.width + 10
                self.image2.frame.origin.x -= self.slider.frame.size.width + 10
                self.image3.frame.origin.x -= self.slider.frame.size.width + 10
            } else {
                self.image1.frame = CGRect(x: 0, y: 0, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
                self.image2.frame = CGRect(x: self.slider.frame.size.width + 10, y: 0, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
                self.image3.frame = CGRect(x: self.slider.frame.size.width * 2 + 20, y: 0, width: self.slider.frame.size.width, height: self.slider.frame.size.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if shopCollection == collectionView {
            return Global.allProducts.count
        } else {
            return Global.allPosts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if shopCollection == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCollectionCell", for: indexPath) as! shopCollectionCell
            let dict = Global.allProducts[indexPath.row]
            cell.title.text = dict[0]
            cell.price.setTitle(dict[1], for: .normal)
            cell.price.setTitleColor(UIColor.darkGray, for: .normal)
            cell.postImage.image = UIImage(named: Global.productsThumbnails[indexPath.row])
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 15

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "blogCollectionCell", for: indexPath) as! blogCollectionCell
            let dict = Global.allPosts[indexPath.row]
            cell.image.image = UIImage(named: Global.postsImages[indexPath.row])
            cell.title.text = dict[0]
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 15

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if shopCollection == collectionView {
            Global.itemInfo = Global.allProducts[indexPath.row]
            Global.itemImage = UIImage(named: Global.productsImages[indexPath.row])!
            Global.itemThumbnail = UIImage(named: Global.productsThumbnails[indexPath.row])!
            performSegue(withIdentifier: "shopItem", sender: self)
        } else {
            Global.itemInfo = Global.allPosts[indexPath.row]
            Global.itemImage = UIImage(named: Global.postsImages[indexPath.row])!
            performSegue(withIdentifier: "post", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if shopCollection == collectionView {
            return CGSize(width: shopCollection.frame.size.width * 2 / 3, height: 80)
        } else {
            return CGSize(width: blogCollection.frame.size.width * 2 / 3, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

class shopCollectionCell: UICollectionViewCell {
    
    var title: UILabel!
    var price: UIButton!
    var postImage: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        price.setTitle(nil, for: .normal)
        postImage.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title = UILabel(frame: CGRect(x: frame.width / 2, y: 0, width: frame.width / 2 - 10, height: 40))
        title.textColor = UIColor.darkGray
        title.textAlignment = .right
        contentView.addSubview(title)
        
        price = UIButton(frame: CGRect(x: frame.width * 2 / 3 - 10, y: 40, width: frame.width / 3, height: 30))
        price.backgroundColor = UIColor(hex: "f2f2f2")
        price.layer.cornerRadius = 12.5
        price.layer.masksToBounds = true
        contentView.addSubview(price)
    
        postImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        postImage.layer.masksToBounds = true
        postImage.layer.cornerRadius = 17.5
        contentView.addSubview(postImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class blogCollectionCell: UICollectionViewCell {
    
    var image: UIImageView!
    var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        title.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 40))
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 17.5
        contentView.addSubview(image)
        
        title = UILabel(frame: CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 40))
        title.textColor = UIColor.darkGray
        title.textAlignment = .center
        contentView.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
