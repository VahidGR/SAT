//
//  ViewController.swift
//  Milad
//
//  Created by Vahid Ghanbarpour on 10/1/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class Test: UIViewController {
    
    var question = UILabel()
    var answerView = UIView()
    var openAnswer = UIButton()
    var questionsView = UIView()
    
    var questionIndex = Int()

    var questionsLabel = [UILabel]()
    var answers = [UIView]()
    var openAnswers = [UIButton]()
    var questions = [UIView]()
    
    var questionsCount = 10
    
    var owned = false
    var paymentPanel = UIView()
    
    @objc func leftSwipe() {
        
        for questionView in self.questions {
            questionView.isHidden = false
        }

        if questionIndex < questionsCount - 1 {
            questionIndex += 1
            UIView.animate(withDuration: 0.3) {
                for questionView in self.questions {
                    questionView.frame.origin.x -= self.view.frame.size.width
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.31, execute: {
            self.setViewOrigin()
        })
    }
    
    @objc func rightSwipe() {
        
        for questionView in self.questions {
            questionView.isHidden = false
        }

        if questionIndex > 1 {
            questionIndex -= 1
            UIView.animate(withDuration: 0.3) {
                for questionView in self.questions {
                    questionView.frame.origin.x += self.view.frame.size.width
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.31, execute: {
                self.setViewOrigin()
            })
        }
        
        questionsLabel.removeAll()
        questions.removeAll()
    }
    
    @objc func upSwipe() {
        let question = UITextView()
        question.backgroundColor = UIColor.clear
        question.textColor = UIColor.white
        UIView.animate(withDuration: 0.2, animations: {
            self.answerView.frame = CGRect(x: self.questionsView.frame.size.width / 20, y: self.questionsView.frame.size.height * 2 / 10, width: self.questionsView.frame.size.width * 9 / 10, height: self.questionsView.frame.size.height * 9 / 10)
            question.frame = CGRect(x: self.answerView.frame.size.width / 14, y: self.answerView.frame.size.height / 14, width: self.answerView.frame.size.width * 12 / 14, height: self.answerView.frame.size.height / 2)
            question.text = "This is a sample answer.\n" + "This is how it will look like"
            question.font = question.font?.withSize(24.0)
            self.answerView.addSubview(question)
        })
    }
    
    @objc func downSwipe() {
        UIView.animate(withDuration: 0.2, animations: {
            self.answerView.frame = CGRect(x: self.questionsView.frame.size.width / 20, y: self.questionsView.frame.size.height * 19 / 20, width: self.questionsView.frame.size.width * 9 / 10, height: self.questionsView.frame.size.height / 10)
            self.answerView.layer.cornerRadius = 40
        })
    }
    
    func setViewOrigin() {
        for i in 0 ..< self.questions.count {
            if self.questions[i].frame.origin.x == 0 {
                self.question = self.questionsLabel[i]
                self.answerView = self.answers[i]
                self.openAnswer = self.openAnswers[i]
                self.questionsView = self.questions[i]
                self.questionIndex = i
            }
        }
        
        for questionView in self.questions {
            if questionView.frame.origin.x != 0 {
                questionView.isHidden = true
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        let questionsSubViews = self.question.subviews
        for subView in questionsSubViews {
            subView.removeFromSuperview()
        }
        let answersSubViews = self.answerView.subviews
        for subView in answersSubViews {
            subView.removeFromSuperview()
        }
        
        questionsLabel.removeAll()
        answers.removeAll()
        openAnswers.removeAll()
        questions.removeAll()
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
        
        for i in 0 ..< questionsCount {
            let iquestion = UILabel()
            let ianswerView = UIView()
            let iopenAnswer = UIButton()
            let iquestionsView = UIView()
            iquestionsView.frame = CGRect(x: view.frame.size.width * CGFloat(i), y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.size.width, height: self.view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!)
            iquestion.frame = CGRect(x: iquestionsView.frame.size.width / 14, y: iquestionsView.frame.size.height / 14, width: iquestionsView.frame.size.width * 12 / 14, height: iquestionsView.frame.size.height / 2)
            iquestion.text = "This is a sample question.\n" + "This is how it will look like"
            iquestion.font = iquestion.font?.withSize(24.0)
            iquestionsView.addSubview(iquestion)
            ianswerView.frame = CGRect(x: iquestionsView.frame.size.width / 20, y: iquestionsView.frame.size.height * 19 / 20, width: iquestionsView.frame.size.width * 9 / 10, height: iquestionsView.frame.size.height / 10)
            ianswerView.backgroundColor = UIColor.blue
            ianswerView.layer.cornerRadius = 40
            ianswerView.layer.masksToBounds = true
            iopenAnswer.frame = CGRect(x: 0, y: 0, width: ianswerView.frame.size.width, height: ianswerView.frame.size.height)
            iopenAnswer.tag = 1
            iopenAnswer.addTarget(self, action: #selector(answersViewController(sender:)), for: .touchUpInside)
            ianswerView.addSubview(iopenAnswer)
            iquestionsView.addSubview(ianswerView)
            view.addSubview(iquestionsView)
            
            questionsLabel.append(iquestion)
            answers.append(ianswerView)
            openAnswers.append(iopenAnswer)
            questions.append(iquestionsView)
        }
        
        let left = UISwipeGestureRecognizer(target : self, action : #selector(leftSwipe))
        left.direction = .left
        view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(rightSwipe))
        right.direction = .right
        view.addGestureRecognizer(right)
        
        let up = UISwipeGestureRecognizer(target : self, action : #selector(upSwipe))
        up.direction = .up
        view.addGestureRecognizer(up)
        
        let down = UISwipeGestureRecognizer(target : self, action : #selector(downSwipe))
        down.direction = .down
        view.addGestureRecognizer(down)
    }
    
    @objc func answersViewController(sender: UIButton) {
        switch sender.tag {
        case 0:
            downSwipe()
            break
        case 1:
            upSwipe()
            break
        default:
            break
        }
    }
}

