//
//  Post.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/24/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class Post: UIViewController {

    var headerImage = UIImageView()
    var postTitle = UILabel()
    var postContent = UILabel()
    
    let relativeFontConstant:CGFloat = 0.025
    let relativeFontConstantT:CGFloat = 0.03
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.title = "پست"
        
        let contentScrollView = UIScrollView(frame: CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.size.width, height: self.view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!))
        self.view.addSubview(contentScrollView)

        headerImage.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width * 9 / 16)
        headerImage.image = Global.itemImage
        postTitle.frame = CGRect(x: 0, y: headerImage.frame.height * 5 / 6, width: view.frame.size.width, height: headerImage.frame.size.height / 6)
        postTitle.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        postTitle.text = "  " + Global.itemInfo[0]
        postTitle.textAlignment = .right
        postTitle.textColor = UIColor.white
        postTitle.font = postTitle.font.withSize(self.view.frame.height * self.relativeFontConstantT)
        headerImage.addSubview(postTitle)
        contentScrollView.addSubview(headerImage)
        
        postContent.frame = CGRect(x: 20, y: headerImage.frame.origin.y + headerImage.frame.size.height + 20, width: view.frame.size.width - 40, height: view.frame.size.height)
        postContent.text = "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد."
        postContent.textColor = UIColor.darkGray
        postContent.font = postContent.font.withSize(self.view.frame.height * self.relativeFontConstant)
        postContent.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: postContent.text!)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        style.minimumLineHeight = 20
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: (postContent.text?.count)!))
        postContent.attributedText = attrString
        postContent.sizeToFit()
        postContent.lineBreakMode = .byWordWrapping
        style.alignment = .right
        contentScrollView.addSubview(postContent)
        
        contentScrollView.contentSize.height = postContent.frame.origin.y + postContent.frame.height + 100
    }
}
