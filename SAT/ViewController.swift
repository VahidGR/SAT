//
//  ViewController.swift
//  Milad
//
//  Created by Vahid Ghanbarpour on 10/1/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var answersView = UIView()
    var openAnswers = UIButton()
    var closeAnswers = UIButton()
    var questionView = UIView()
    
    var question1 = UITextView()
    var answersView1 = UIView()
    var openAnswers1 = UIButton()
    var closeAnswers1 = UIButton()
    var questionView1 = UIView()
    
    var question2 = UITextView()
    var questionView2 = UIView()
    var answersView2 = UIView()
    var openAnswers2 = UIButton()
    var closeAnswers2 = UIButton()
    
    var question3 = UITextView()
    var questionView3 = UIView()
    var answersView3 = UIView()
    var openAnswers3 = UIButton()
    var closeAnswers3 = UIButton()
    
    var questionsArray = [UIView]()
    
    var questionNumber = 1
    
    var owned = false
    var paymentPanel = UIView()
    
    @objc func leftSwipe() {
        
        for qView in questionsArray {
            qView.isHidden = false
        }

        questionNumber += 1
        UIView.animate(withDuration: 0.3) {
            self.questionView1.frame.origin.x -= self.view.frame.size.width
            self.questionView2.frame.origin.x -= self.view.frame.size.width
            self.questionView3.frame.origin.x -= self.view.frame.size.width
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.31, execute: {
            self.setViewOrigin()
        })
    }
    
    @objc func rightSwipe() {
        
        for qView in questionsArray {
            qView.isHidden = false
        }

        if questionNumber > 1 {
            questionNumber -= 1
            UIView.animate(withDuration: 0.3) {
                self.questionView1.frame.origin.x += self.view.frame.size.width
                self.questionView2.frame.origin.x += self.view.frame.size.width
                self.questionView3.frame.origin.x += self.view.frame.size.width
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.31, execute: {
                self.setViewOrigin()
            })
        }
    }
    
    func setViewOrigin() {
        if self.questionView1.frame.origin.x == -self.view.frame.size.width * 2 {
            self.questionView1.frame.origin.x = self.view.frame.size.width
        }
        if self.questionView2.frame.origin.x == -self.view.frame.size.width * 2 {
            self.questionView2.frame.origin.x = self.view.frame.size.width
        }
        if self.questionView3.frame.origin.x == -self.view.frame.size.width * 2 {
            self.questionView3.frame.origin.x = self.view.frame.size.width
        }

        if self.questionView1.frame.origin.x == self.view.frame.size.width * 2 {
            self.questionView1.frame.origin.x = -self.view.frame.size.width
        }
        if self.questionView2.frame.origin.x == self.view.frame.size.width * 2 {
            self.questionView2.frame.origin.x = -self.view.frame.size.width
        }
        if self.questionView3.frame.origin.x == self.view.frame.size.width * 2 {
            self.questionView3.frame.origin.x = -self.view.frame.size.width
        }

        if self.questionView1.frame.origin.x == 0 {
            self.answersView = self.answersView1
            self.openAnswers = self.openAnswers1
            self.questionView = self.questionView1
            self.closeAnswers = self.closeAnswers1
        } else if self.questionView2.frame.origin.x == 0 {
            self.answersView = self.answersView2
            self.openAnswers = self.openAnswers2
            self.questionView = self.questionView2
            self.closeAnswers = self.closeAnswers2
        } else {
            self.answersView = self.answersView3
            self.openAnswers = self.openAnswers3
            self.questionView = self.questionView3
            self.closeAnswers = self.closeAnswers3
        }
        
        for qView in questionsArray {
            if qView.frame.origin.x != 0 {
                qView.isHidden = true
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        let questionsSubViews = self.questionView.subviews
        for subView in questionsSubViews {
            subView.removeFromSuperview()
        }
        let answersSubViews = self.answersView.subviews
        for subView in answersSubViews {
            subView.removeFromSuperview()
        }
        
        questionsArray.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Global.firstTime {
            let startLabel = UILabel(frame: CGRect(x: 0, y: view.frame.size.height / 3, width: view.frame.size.width, height: view.frame.size.height / 6))
            startLabel.text = "شروع آزمون؟"
            startLabel.font = UIFont.systemFont(ofSize: 40.0)
            startLabel.textAlignment = .center
            view.addSubview(startLabel)
            
            let startButton = UIButton(frame: CGRect(x: view.frame.size.width / 3, y: startLabel.frame.origin.y + startLabel.frame.size.height + 100, width: view.frame.size.width / 3, height: 60))
            startButton.setTitle("شروع کن", for: .normal)
            startButton.setTitleColor(UIColor.white, for: .normal)
            if owned {
                startButton.addTarget(self, action: #selector(loadQuestions), for: .touchUpInside)
            } else {
                startButton.addTarget(self, action: #selector(makePayment), for: .touchUpInside)
            }
            startButton.layer.masksToBounds = true
            startButton.layer.cornerRadius = 15
            startButton.backgroundColor = UIColor.blue
            view.addSubview(startButton)
            
            paymentPanel.frame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height / 2)
            paymentPanel.backgroundColor = UIColor(hex: "a4a4a4")
            paymentPanel.layer.masksToBounds = true
            paymentPanel.layer.cornerRadius = 10
            view.addSubview(paymentPanel)
            
            let priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: paymentPanel.frame.width, height: paymentPanel.frame.size.height / 2))
            priceLabel.textAlignment = .center
            priceLabel.textColor = UIColor.white
            priceLabel.text = "خرید آزمون" + "\n۱۵۰۰۰ تومان"
            paymentPanel.addSubview(priceLabel)
            
            let paymentButton = UIButton(frame: CGRect(x: view.frame.size.width / 10, y: paymentPanel.frame.size.height * 5 / 8, width: view.frame.size.width * 8 / 10, height: paymentPanel.frame.size.height / 4))
            paymentButton.backgroundColor = UIColor.white
            paymentButton.setTitle("پرداخت آنلاین", for: .normal)
            paymentButton.layer.masksToBounds = true
            paymentButton.layer.cornerRadius = 15
            paymentButton.setTitleColor(UIColor.brown, for: .normal)
            paymentButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
            paymentPanel.addSubview(paymentButton)
        }
    }
    
    @objc func makePayment() {
        UIView.animate(withDuration: 0.2) {
            self.paymentPanel.frame = CGRect(x: 0, y: self.view.frame.size.height / 2, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
        }
    }
    
    @objc func pay() {
        UIView.animate(withDuration: 0.2) {
            self.paymentPanel.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            UIView.animate(withDuration: 0.3, animations: {
                self.loadQuestions()
            })
        })
    }
    
    @objc func loadQuestions() {
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        
        let left = UISwipeGestureRecognizer(target : self, action : #selector(leftSwipe))
        left.direction = .left
        view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(rightSwipe))
        right.direction = .right
        view.addGestureRecognizer(right)
        
        questionView1.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!)
        questionView2.frame = CGRect(x: view.frame.size.width, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!)
        questionView3.frame = CGRect(x: view.frame.size.width * 2, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!)

        // QuestionView1
        question1.frame = CGRect(x: questionView1.frame.size.width / 14, y: questionView1.frame.size.height / 14, width: questionView1.frame.size.width * 12 / 14, height: questionView1.frame.size.height / 2)
        question1.text = "This is a sample question.\n" + "This is how it will look like"
        question1.font = question1.font?.withSize(24.0)
        question1.isEditable = false
        questionView1.addSubview(question1)
        answersView1.frame = CGRect(x: questionView1.frame.size.width / 20, y: questionView1.frame.size.height * 19 / 20, width: questionView1.frame.size.width * 9 / 10, height: questionView1.frame.size.height / 10)
        answersView1.backgroundColor = UIColor.blue
        answersView1.layer.cornerRadius = 40
        answersView1.layer.masksToBounds = true
        openAnswers1.frame = CGRect(x: 0, y: 0, width: answersView1.frame.size.width, height: answersView1.frame.size.height)
        openAnswers1.tag = 1
        openAnswers1.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
        answersView1.addSubview(openAnswers1)
        questionView1.addSubview(answersView1)
        closeAnswers1.tag = 0
        closeAnswers1.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
        
        // QuestionView2
        question2.frame = CGRect(x: questionView2.frame.size.width / 14, y: questionView2.frame.size.height / 14, width: questionView2.frame.size.width * 12 / 14, height: questionView2.frame.size.height / 2)
        question2.text = "This is a sample question.\n" + "This is how it will look like"
        question2.font = question2.font?.withSize(24.0)
        question2.isEditable = false
        questionView2.addSubview(question2)
        answersView2.frame = CGRect(x: questionView2.frame.size.width / 20, y: questionView2.frame.size.height * 19 / 20, width: questionView2.frame.size.width * 9 / 10, height: questionView2.frame.size.height / 10)
        answersView2.backgroundColor = UIColor.blue
        answersView2.layer.cornerRadius = 40
        answersView2.layer.masksToBounds = true
        openAnswers2.frame = CGRect(x: 0, y: 0, width: answersView2.frame.size.width, height: answersView2.frame.size.height)
        openAnswers2.tag = 1
        openAnswers2.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
        answersView2.addSubview(openAnswers2)
        questionView2.addSubview(answersView2)
        closeAnswers2.tag = 0
        closeAnswers2.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
        
        // QuestionView3
        question3.frame = CGRect(x: questionView3.frame.size.width / 14, y: questionView3.frame.size.height / 14, width: questionView3.frame.size.width * 12 / 14, height: questionView3.frame.size.height / 2)
        question3.text = "This is a sample question.\n" + "This is how it will look like"
        question3.font = question3.font?.withSize(24.0)
        question3.isEditable = false
        questionView3.addSubview(question3)
        answersView3.frame = CGRect(x: questionView3.frame.size.width / 20, y: questionView3.frame.size.height * 19 / 20, width: questionView3.frame.size.width * 9 / 10, height: questionView3.frame.size.height / 10)
        answersView3.backgroundColor = UIColor.blue
        answersView3.layer.cornerRadius = 40
        answersView3.layer.masksToBounds = true
        openAnswers3.frame = CGRect(x: 0, y: 0, width: answersView3.frame.size.width, height: answersView3.frame.size.height)
        openAnswers3.tag = 1
        openAnswers3.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
        answersView3.addSubview(openAnswers3)
        questionView3.addSubview(answersView3)
        openAnswers3.tag = 0
        openAnswers3.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
        
        answersView = answersView1
        openAnswers = openAnswers1
        questionView = questionView1
        closeAnswers = closeAnswers1
        
        view.addSubview(questionView1)
        view.addSubview(questionView2)
        view.addSubview(questionView3)
        
        questionsArray.append(questionView1)
        questionsArray.append(questionView2)
        questionsArray.append(questionView3)
    }
    
    @objc func answersViewController(sender: UIButton) {
        switch sender.tag {
        case 0:
            UIView.animate(withDuration: 0.2, animations: {
                self.answersView.frame = CGRect(x: self.questionView.frame.size.width / 20, y: self.questionView.frame.size.height * 19 / 20, width: self.questionView.frame.size.width * 9 / 10, height: self.questionView.frame.size.height / 10)
                self.answersView.layer.cornerRadius = 40
            })
            break
        case 1:
            self.questionView.addSubview(closeAnswers)
            closeAnswers.frame = CGRect(x: 0, y: self.questionView.frame.size.height / 10, width: self.questionView.frame.size.width, height: self.questionView.frame.size.height / 10)
            let question = UITextView()
            question.backgroundColor = UIColor.clear
            question.textColor = UIColor.white
            UIView.animate(withDuration: 0.2, animations: {
                self.answersView.frame = CGRect(x: self.questionView.frame.size.width / 20, y: self.questionView.frame.size.height * 2 / 10, width: self.questionView.frame.size.width * 9 / 10, height: self.questionView.frame.size.height * 9 / 10)
                question.frame = CGRect(x: self.answersView.frame.size.width / 14, y: self.answersView.frame.size.height / 14, width: self.answersView.frame.size.width * 12 / 14, height: self.answersView.frame.size.height / 2)
                question.text = "This is a sample answer.\n" + "This is how it will look like"
                question.font = question.font?.withSize(24.0)
                self.answersView.addSubview(question)
            })
            break
        default:
            break
        }
    }
}

