//
//  BlogEnrollment.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/22/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class BlogEnrollment: UIViewController {
    
    var enrollButton = UIButton()
    var remainingSubscription = UILabel()
    var subscriptionPros = UILabel()
    var enrollmentPanel = UIView()
    
    let relativeFontConstant:CGFloat = 0.025
    let relativeFontConstantT:CGFloat = 0.05
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.title = "اشتراک بلاگ"
        
        remainingSubscription.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height / 4)
        remainingSubscription.text = "۳۰ روز باقی مانده"
        remainingSubscription.textAlignment = .center
        remainingSubscription.textColor = UIColor.gray
        remainingSubscription.font = remainingSubscription.font.withSize(self.view.frame.height * self.relativeFontConstantT)
        view.addSubview(remainingSubscription)

        subscriptionPros.frame = CGRect(x: 20, y: remainingSubscription.frame.origin.y + remainingSubscription.frame.size.height, width: view.frame.size.width - 40, height: 100)
        subscriptionPros.text = "بازدید از پست های ویژه"
        subscriptionPros.textColor = UIColor.purple
        subscriptionPros.textAlignment = .center
        subscriptionPros.font = subscriptionPros.font.withSize(self.view.frame.height * self.relativeFontConstant)
        view.addSubview(subscriptionPros)
        
        enrollButton.frame = CGRect(x: 0, y: view.frame.height * 9 / 10, width: view.frame.size.width, height: view.frame.height / 10)
        enrollButton.backgroundColor = UIColor.red
        enrollButton.setTitle("Enroll", for: .normal)
        enrollButton.titleLabel?.textColor = UIColor.white
        enrollButton.addTarget(self, action: #selector(enroll), for: .touchUpInside)
        view.addSubview(enrollButton)
        
        enrollmentPanel.frame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 0)
        enrollmentPanel.backgroundColor = UIColor.green
        enrollmentPanel.layer.masksToBounds = true
        enrollmentPanel.layer.cornerRadius = 10
        view.addSubview(enrollmentPanel)
    }
    
    @objc func enroll() {
        UIView.animate(withDuration: 0.2) {
            self.enrollmentPanel.frame = CGRect(x: 0, y: self.view.frame.size.height / 2 + 10, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
            let closePanel = UITapGestureRecognizer(target: self, action: #selector(self.closePanelAction))
            self.enrollmentPanel.addGestureRecognizer(closePanel)
        }
    }
    
    @objc func closePanelAction() {
        UIView.animate(withDuration: 0.2) {
            self.enrollmentPanel.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 0)
        }
    }
}
