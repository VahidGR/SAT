//
//  Profile.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/22/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    var scrollView = UIScrollView()
    
    var profileImage = UIImageView()
    var username = UILabel()
    var indexView = UIButton()
    var enrollmentStatus = UIButton()
    var enrollmentStatusText = UILabel()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        let scrollViewSubViews = self.scrollView.subviews
        for subView in scrollViewSubViews {
            subView.removeFromSuperview()
        }
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        scrollView = UIScrollView(frame: CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)! - (tabBarController?.tabBar.frame.size.height)!))
        view.addSubview(scrollView)

        self.tabBarController!.title = "حساب کاربری"
        self.tabBarController!.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openShoppingCard)), animated: true)

        let profileBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width * 9 / 16))
        profileBackground.image = UIImage(named: "pb")
        scrollView.addSubview(profileBackground)
        
        let editButton = UIButton(frame: CGRect(x: view.frame.size.width - 60, y: 20, width: 40, height: 40))
        editButton.setImage(UIImage(named: "edit"), for: .normal)
        editButton.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        profileBackground.addSubview(editButton)
        
        profileImage.frame = CGRect(x: view.frame.size.width / 2 - (view.frame.size.width / 8), y: view.frame.size.width / 12, width: view.frame.size.width / 4, height: view.frame.size.width / 4)
        profileImage.image = UIImage(named: "profile")
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = view.frame.size.width / 8
        profileBackground.addSubview(profileImage)
        
        username.frame = CGRect(x: 0, y: profileBackground.frame.size.height - (view.frame.size.width / 4), width: view.frame.size.width, height: view.frame.size.width / 5)
        username.text = "وحید قنبرپور"
        username.textAlignment = .center
        username.textColor = UIColor.white
        username.font = UIFont.systemFont(ofSize: 30.0)
        profileBackground.addSubview(username)
        
        indexView.frame = CGRect(x: view.frame.size.width / 20, y: profileBackground.frame.origin.y + profileBackground.frame.size.height + 30, width: view.frame.size.width * 18 / 20, height: view.frame.size.width * 18 / 40)
        indexView.backgroundColor = UIColor(hex: "f2f2f2")
        indexView.layer.masksToBounds = true
        indexView.layer.cornerRadius = 15
        indexView.addTarget(self, action: #selector(indexPressed), for: .touchUpInside)
        indexView.setImage(UIImage(named: "line-filled"), for: .normal)
        scrollView.addSubview(indexView)
        
        enrollmentStatus.frame = CGRect(x: view.frame.size.width / 20, y: indexView.frame.origin.y + indexView.frame.size.height + 30, width: view.frame.size.width * 18 / 20, height: view.frame.size.width / 2)
        enrollmentStatus.backgroundColor = UIColor.blue
        enrollmentStatus.layer.masksToBounds = true
        enrollmentStatus.layer.cornerRadius = 15
        enrollmentStatus.addTarget(self, action: #selector(enroll), for: .touchUpInside)
        enrollmentStatusText.frame = CGRect(x: 0, y: 0, width: enrollmentStatus.frame.size.width, height: enrollmentStatus.frame.size.height)
        enrollmentStatusText.text = "30 days left"
        enrollmentStatusText.textColor = UIColor.white
        enrollmentStatusText.textAlignment = .center
        enrollmentStatusText.font = UIFont.systemFont(ofSize: 40.0)
        enrollmentStatus.addSubview(enrollmentStatusText)
        scrollView.addSubview(enrollmentStatus)
        
        scrollView.contentSize.height = enrollmentStatus.frame.origin.y + view.frame.size.width / 2 + 50
    }
    
    @objc func editPressed() {
        
    }
    
    @objc func indexPressed() {
        
    }
    
    @objc func enroll() {
        performSegue(withIdentifier: "blogEnrollment", sender: self)
    }
    
    @objc func openShoppingCard() {
        performSegue(withIdentifier: "shoppingCard", sender: self)
    }
}
