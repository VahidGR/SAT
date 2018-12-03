//
//  EditProfile.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 11/7/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class EditProfile: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var scrollView = UIScrollView()
    var profileImage = UIImageView()
    var nameField = UITextField()
    var phoneNumberField = UITextField()
    var emailField = UITextField()
    var pickerContainer = UIView()
    var day = UIPickerView()
    var month = UIPickerView()
    var year = UIPickerView()
    var educationalLicense = UIPickerView()
    var dayArray = [String]()
    var monthArray = ["فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"]
    var yearArray = [String]()
    var educationArray = ["زیر دیپلم", "دیپلم", "کاردانی", "کارشناسی", "کارشناسی ارشد", "دکتری"]

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }
        
        let pickerSubViews = self.view.subviews
        for subView in pickerSubViews {
            subView.removeFromSuperview()
        }

        dayArray.removeAll()
        yearArray.removeAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = "ویرایش کاربر"
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.size.width, height: view.frame.size.height - (navigationController?.navigationBar.frame.size.height)! - view.frame.height / 10))
        let closeKeyboard = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardAction))
        scrollView.addGestureRecognizer(closeKeyboard)
        view.addSubview(scrollView)

        profileImage.frame = CGRect(x: 20, y: 20, width: view.frame.size.width / 4, height: view.frame.size.width / 4)
        profileImage.image = Global.profilePicture
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = view.frame.size.width / 8
        scrollView.addSubview(profileImage)
        
        nameField.frame = CGRect(x: profileImage.frame.origin.x + profileImage.frame.size.width + 20, y: view.frame.size.width / 8, width: scrollView.frame.size.width - profileImage.frame.origin.x - profileImage.frame.size.width - 40, height: 40)
        nameField.text = Global.profileName
        nameField.textAlignment = .right
        nameField.placeholder = "نام و نام خانوادگی"
        nameField.clearButtonMode = .always
        nameField.backgroundColor = UIColor(hex: "f2f2f2")
        nameField.layer.masksToBounds = true
        nameField.layer.cornerRadius = 10
        nameField.delegate = self
        nameField.returnKeyType = .done
        scrollView.addSubview(nameField)
        
        emailField.frame = CGRect(x: 40, y: profileImage.frame.origin.y + profileImage.frame.size.height + 40, width: scrollView.frame.size.width - 80, height: 40)
        emailField.placeholder = "E-mail"
        emailField.textAlignment = .center
        emailField.clearButtonMode = .always
        emailField.keyboardType = .emailAddress
        emailField.backgroundColor = UIColor(hex: "f2f2f2")
        emailField.layer.masksToBounds = true
        emailField.layer.cornerRadius = 10
        emailField.delegate = self
        emailField.returnKeyType = .done
        scrollView.addSubview(emailField)
        
        phoneNumberField.frame = CGRect(x: 40, y: emailField.frame.origin.y + emailField.frame.size.height + 30, width: scrollView.frame.size.width - 80, height: 40)
        phoneNumberField.placeholder = "شماره تلفن: 09101234567"
        phoneNumberField.textAlignment = .center
        phoneNumberField.clearButtonMode = .always
        phoneNumberField.keyboardType = .asciiCapableNumberPad
        phoneNumberField.backgroundColor = UIColor(hex: "f2f2f2")
        phoneNumberField.layer.masksToBounds = true
        phoneNumberField.layer.cornerRadius = 10
        phoneNumberField.delegate = self
        phoneNumberField.returnKeyType = .done
        scrollView.addSubview(phoneNumberField)
        
        for i in (1300...1397).reversed() {
            yearArray.append(String(i))
        }
        
        for i in 1...31 {
            dayArray.append(String(i))
        }

        let birthdayLabel = UILabel(frame: CGRect(x: 20, y: phoneNumberField.frame.origin.y + 80, width: scrollView.frame.size.width - 40, height: 40))
        birthdayLabel.text = "تاریخ تولد"
        birthdayLabel.textAlignment = .right
        birthdayLabel.textColor = UIColor.darkGray
        scrollView.addSubview(birthdayLabel)
        
        pickerContainer.frame = CGRect(x: 21, y: birthdayLabel.frame.origin.y + 20, width: scrollView.frame.size.width - 42, height: scrollView.frame.size.width * 2 / 3)
        day.frame = CGRect(x: 0, y: 0, width: pickerContainer.frame.size.width / 3, height: pickerContainer.frame.size.height)
        month.frame = CGRect(x: pickerContainer.frame.size.width / 3, y: 0, width: pickerContainer.frame.size.width / 3, height: pickerContainer.frame.size.height)
        year.frame = CGRect(x: pickerContainer.frame.size.width * 2 / 3, y: 0, width: pickerContainer.frame.size.width / 3, height: pickerContainer.frame.size.height)
        day.delegate = self
        day.dataSource = self
        month.delegate = self
        month.dataSource = self
        year.delegate = self
        year.dataSource = self
        pickerContainer.addSubview(day)
        pickerContainer.addSubview(month)
        pickerContainer.addSubview(year)
        scrollView.addSubview(pickerContainer)
        
        let educationLabel = UILabel(frame: CGRect(x: 20, y: pickerContainer.frame.origin.y + pickerContainer.frame.size.height + 40, width: scrollView.frame.size.width - 40, height: 40))
        educationLabel.text = "آخرین مدرک دانشگاهی"
        educationLabel.textAlignment = .right
        educationLabel.textColor = UIColor.darkGray
        scrollView.addSubview(educationLabel)

        educationalLicense.frame = CGRect(x: 20, y: educationLabel.frame.origin.y + 20, width: pickerContainer.frame.size.width, height: pickerContainer.frame.size.height)
        educationalLicense.delegate = self
        educationalLicense.dataSource = self
//        educationalLicense.selectedRow(inComponent: Global.educationIndex)
        scrollView.addSubview(educationalLicense)
        
        scrollView.contentSize.height = educationalLicense.frame.origin.y + educationalLicense.frame.size.height + 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if day == pickerView {
            return dayArray.count
        } else if month == pickerView {
            return monthArray.count
        } else if year == pickerView {
            return yearArray.count
        } else {
            return educationArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if day == pickerView {
            return dayArray[row]
        } else if month == pickerView {
            return monthArray[row]
        } else if year == pickerView {
            return yearArray[row]
        } else {
            return educationArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if day == pickerView {

        } else if month == pickerView {
            dayArray.removeAll()
            if row < 6 {
                for i in 1...31 {
                    dayArray.append(String(i))
                }
            } else if row > 5 && row < 11 {
                for i in 1...30 {
                    dayArray.append(String(i))
                }
            } else {
                for i in 1...29 {
                    dayArray.append(String(i))
                }
            }
            day.selectRow(0, inComponent: 0, animated: true)
            day.reloadAllComponents()
        } else if year == pickerView {

        } else {
            Global.educationIndex = row
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboardAction()
        return true
    }

    @objc func closeKeyboardAction() {
        view.endEditing(true)
    }
}
