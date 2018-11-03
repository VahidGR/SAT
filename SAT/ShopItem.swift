//
//  ShopItem.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/24/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class ShopItem: UIViewController {

    var slider = UIView()
    var image1 = UIImageView()
    var image2 = UIImageView()
    var image3 = UIImageView()
    
    var itemTitle = UILabel()
    var itemPrice = UILabel()
    var itemContent = UILabel()
    var addToCardButton = UIButton()
    
    let relativeFontConstant:CGFloat = 0.025
    let relativeFontConstantT:CGFloat = 0.03
    
    var productInfo = [String]()

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.title = "آیتم"

        let contentScrollView = UIScrollView(frame: CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.size.width, height: view.frame.size.height - (navigationController?.navigationBar.frame.size.height)! - view.frame.height / 10))
        self.view.addSubview(contentScrollView)

        slider.frame = CGRect(x: contentScrollView.frame.size.width / 20, y: 10, width: contentScrollView.frame.size.width * 18 / 20, height: (contentScrollView.frame.size.width * 18 / 20) * 9 / 16)
        
        image1.frame = CGRect(x: 0, y: 0, width: slider.frame.size.width, height: slider.frame.size.height)
        image2.frame = CGRect(x: slider.frame.size.width + 10, y: 0, width: slider.frame.size.width, height: slider.frame.size.height)
        image3.frame = CGRect(x: slider.frame.size.width * 2 + 20, y: 0, width: slider.frame.size.width, height: slider.frame.size.height)
        
        image1.image = Global.itemImage
        image2.image = Global.itemImage
        image3.image = Global.itemImage
        
        image1.layer.masksToBounds = true
        image2.layer.masksToBounds = true
        image3.layer.masksToBounds = true
        
        image1.layer.cornerRadius = 15
        image2.layer.cornerRadius = 15
        image3.layer.cornerRadius = 15

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        slider.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        slider.addGestureRecognizer(swipeRight)
        
        slider.addSubview(image1)
        slider.addSubview(image2)
        slider.addSubview(image3)
        
        image1.layer.cornerRadius = 15
        image2.layer.cornerRadius = 15
        image3.layer.cornerRadius = 15
        
        contentScrollView.addSubview(slider)
        
        itemTitle.frame = CGRect(x: 20, y: slider.frame.origin.y + slider.frame.size.height + 20, width: view.frame.size.width - 40, height: 50)
        itemTitle.text = "  " + Global.itemInfo[0]
        itemTitle.textAlignment = .right
        itemTitle.textColor = UIColor.black
        itemTitle.font = itemTitle.font.withSize(self.view.frame.height * self.relativeFontConstantT)
        contentScrollView.addSubview(itemTitle)
        
        itemPrice.frame = CGRect(x: 10, y: 10, width: view.frame.size.width / 3, height: 30)
        itemPrice.layer.masksToBounds = true
        itemPrice.layer.cornerRadius = 15
        itemPrice.text = Global.itemInfo[1] + " تومان"
        itemPrice.textAlignment = .center
        itemPrice.backgroundColor = UIColor.blue
        itemPrice.textColor = UIColor.white
        itemTitle.addSubview(itemPrice)
        
        itemContent.frame = CGRect(x: 20, y: slider.frame.origin.y + slider.frame.size.height + 90, width: view.frame.size.width - 40, height: view.frame.size.height)
        itemContent.text = "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد."
        itemContent.textColor = UIColor.darkGray
        itemContent.font = itemContent.font.withSize(self.view.frame.height * self.relativeFontConstant)
        itemContent.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: itemContent.text!)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.minimumLineHeight = 20
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: (itemContent.text?.count)!))
        itemContent.attributedText = attrString
        itemContent.sizeToFit()
        itemContent.lineBreakMode = .byWordWrapping
        style.alignment = .right
        contentScrollView.addSubview(itemContent)

        addToCardButton.frame = CGRect(x: 0, y: view.frame.height * 9 / 10, width: view.frame.size.width, height: view.frame.height / 10)
        addToCardButton.backgroundColor = UIColor.green
        addToCardButton.setTitle("Add to card", for: .normal)
        addToCardButton.titleLabel?.textColor = UIColor.darkGray
        addToCardButton.addTarget(self, action: #selector(addToCard), for: .touchUpInside)
        view.addSubview(addToCardButton)
        
        contentScrollView.contentSize.height = itemContent.frame.origin.y + itemContent.frame.height + 100
        
        productInfo = Global.itemInfo
    }
    
    @objc func handleGesture(sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizer.Direction.right {
            UIView.animate(withDuration: 0.3) {
                if self.image1.frame.origin.x < 0 {
                    self.image1.frame.origin.x += self.slider.frame.size.width + 10
                    self.image2.frame.origin.x += self.slider.frame.size.width + 10
                    self.image3.frame.origin.x += self.slider.frame.size.width + 10
                }
            }
        } else if sender.direction == UISwipeGestureRecognizer.Direction.left {
            UIView.animate(withDuration: 0.3) {
                if self.image3.frame.origin.x > 0 {
                    self.image1.frame.origin.x -= self.slider.frame.size.width + 10
                    self.image2.frame.origin.x -= self.slider.frame.size.width + 10
                    self.image3.frame.origin.x -= self.slider.frame.size.width + 10
                }
            }
        }
    }
    
    @objc func addToCard() {
        Global.productInfo.append(productInfo)
        Global.cardImages.append(Global.itemThumbnail)
    }
}
