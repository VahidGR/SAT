//
//  ShoppingCard.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 10/25/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class ShoppingCard: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var itemCollection: UICollectionView!
    var paymentButton = UIButton()
    var contentScrollView = UIScrollView()
    var paymentPanel = UIView()
    var buttons = [UIButton]()
    var addresses = [String]()
    var productCount = [Int]()
    
    var payOnLocation = UIButton()
    var payOnline = UIButton()
    
    var shadowPanel = UIView()
    var deleteItemView = UIView()
    var deleteItemIndex = Int()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let subViews = self.view.subviews
        for subView in subViews {
            subView.removeFromSuperview()
        }

        let panelSubViews = self.shadowPanel.subviews
        for subView in panelSubViews {
            subView.removeFromSuperview()
        }

        let deleteItemSubViews = self.deleteItemView.subviews
        for subView in deleteItemSubViews {
            subView.removeFromSuperview()
        }

        addresses.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.title = "سبد خرید"

        if Global.productInfo.count <= 0 {
            let noProductsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            noProductsLabel.text = "هیچ آیتمی انتخاب نشده"
            noProductsLabel.textColor = UIColor.darkGray
            noProductsLabel.textAlignment = .center
            noProductsLabel.font = UIFont.systemFont(ofSize: 30.0)
            view.addSubview(noProductsLabel)
        } else {
            contentScrollView.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.size.width, height: self.view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)! - view.frame.height / 10)
            self.view.addSubview(contentScrollView)

            let itemFlowLayout = UICollectionViewFlowLayout()
            itemFlowLayout.scrollDirection = .vertical
            
            itemCollection = UICollectionView(frame: CGRect(x: view.frame.size.width / 20, y: 0, width: view.frame.size.width * 18 / 20, height: view.frame.size.width / 2), collectionViewLayout: itemFlowLayout)
            itemCollection.register(itemViewCollectionCell.self, forCellWithReuseIdentifier: "itemViewCollectionCell")
            itemCollection.delegate = self
            itemCollection.dataSource = self
            itemCollection.backgroundColor = UIColor.clear
            itemCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
            itemCollection.showsVerticalScrollIndicator = false
            itemCollection.showsHorizontalScrollIndicator = false
            contentScrollView.addSubview(itemCollection)
            
            paymentButton.frame = CGRect(x: 0, y: view.frame.height * 9 / 10, width: view.frame.size.width, height: view.frame.height / 10)
            paymentButton.backgroundColor = UIColor.green
            paymentButton.setTitle("Payment", for: .normal)
            paymentButton.titleLabel?.textColor = UIColor.darkGray
            paymentButton.addTarget(self, action: #selector(payment), for: .touchUpInside)
            view.addSubview(paymentButton)
            
            paymentPanel.frame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height / 2)
            paymentPanel.backgroundColor = UIColor(hex: "a4a4a4")
            paymentPanel.layer.masksToBounds = true
            paymentPanel.layer.cornerRadius = 10
            view.addSubview(paymentPanel)
            
            payOnLocation.frame = CGRect(x: view.frame.size.width / 10, y: paymentPanel.frame.size.height - 150, width: view.frame.size.width * 8 / 10, height: 50)
            payOnLocation.backgroundColor = UIColor.white
            payOnLocation.setTitle("پرداخت در محل", for: .normal)
            payOnLocation.layer.masksToBounds = true
            payOnLocation.layer.cornerRadius = 15
            payOnLocation.setTitleColor(UIColor.brown, for: .normal)
            paymentPanel.addSubview(payOnLocation)
            
            payOnline.frame = CGRect(x: view.frame.size.width / 10, y: paymentPanel.frame.size.height - 80, width: view.frame.size.width * 8 / 10, height: 50)
            payOnline.backgroundColor = UIColor.white
            payOnline.setTitle("پرداخت آنلاین", for: .normal)
            payOnline.layer.masksToBounds = true
            payOnline.layer.cornerRadius = 15
            payOnline.setTitleColor(UIColor.brown, for: .normal)
            paymentPanel.addSubview(payOnline)
            
            for i in 1...3 {
                addresses.append("آدرس شماره " + String(i))
            }
            
            for i in 0..<addresses.count {
                var button = UIButton()
                if i == 0 {
                    button.frame = CGRect(x: self.view.frame.size.width / 10, y: self.itemCollection.frame.origin.y + self.itemCollection.frame.size.height + 50, width: self.view.frame.size.width * 8 / 10, height: 50)
                } else {
                    button.frame = CGRect(x: self.view.frame.size.width / 10, y: self.buttons[i - 1].frame.origin.y + self.buttons[i - 1].frame.size.height + 20, width: self.view.frame.size.width * 8 / 10, height: 50)
                }
                button.setTitle(addresses[i], for: .normal)
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hex: "f2f2f2")
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 15
                buttons.append(button)
            }
            
            for i in 0 ..< buttons.count {
                buttons[i].addTarget(self, action: #selector(selectAddress), for: .touchUpInside)
                buttons[i].tag = i
                contentScrollView.addSubview(buttons[i])
            }
            
            for i in 0 ..< Global.productInfo.count {
                productCount.append(1)
            }
            
            // delete item panel
            shadowPanel.frame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height)
            shadowPanel.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
            deleteItemView.frame = CGRect(x: view.frame.size.width / 10, y: view.frame.size.height * 5 / 12, width: view.frame.size.width * 8 / 10, height: view.frame.size.height / 6)
            deleteItemView.layer.masksToBounds = true
            deleteItemView.layer.cornerRadius = 15
            deleteItemView.backgroundColor = UIColor(hex: "f2f2f2")
            let alertLabel = UILabel(frame: CGRect(x: 0, y: 0, width: deleteItemView.frame.width, height: deleteItemView.frame.size.height / 3))
            alertLabel.text = "آیا این محصول از سبد خرید حذف شود؟"
            alertLabel.textAlignment = .center
            alertLabel.textColor = UIColor.darkGray
            deleteItemView.addSubview(alertLabel)
            let yes = UIButton(frame: CGRect(x: deleteItemView.frame.width / 2 + 5, y: deleteItemView.frame.size.height * 2 / 3, width: deleteItemView.frame.width / 2 - 10, height: deleteItemView.frame.size.height / 3 - 5))
            yes.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
            yes.setTitle("آره", for: .normal)
            yes.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            yes.backgroundColor = UIColor.red
            yes.layer.masksToBounds = true
            yes.layer.cornerRadius = 15
            deleteItemView.addSubview(yes)
            let no = UIButton(frame: CGRect(x: 5, y: deleteItemView.frame.size.height * 2 / 3, width: deleteItemView.frame.width / 2 - 10, height: deleteItemView.frame.size.height / 3 - 5))
            no.addTarget(self, action: #selector(keepItem), for: .touchUpInside)
            no.setTitle("نه", for: .normal)
            no.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            no.backgroundColor = UIColor.green
            no.layer.masksToBounds = true
            no.layer.cornerRadius = 15
            deleteItemView.addSubview(no)
            shadowPanel.addSubview(deleteItemView)
            view.addSubview(shadowPanel)
        }
    }
    
    @objc func selectAddress(sender: UIButton) {
        for button in buttons {
            if button.tag == sender.tag {
                button.backgroundColor = UIColor.blue
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hex: "f2f2f2")
            }
        }
    }
    
    @objc func payment() {
        UIView.animate(withDuration: 0.2) {
            self.paymentPanel.frame = CGRect(x: 0, y: self.view.frame.size.height / 2 + 10, width: self.view.frame.size.width, height: self.view.frame.size.height / 2)
            let closePanel = UITapGestureRecognizer(target: self, action: #selector(self.closePanelAction))
            self.paymentPanel.addGestureRecognizer(closePanel)
        }
    }
    
    @objc func closePanelAction() {
        UIView.animate(withDuration: 0.2) {
            self.paymentPanel.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Global.productInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemViewCollectionCell", for: indexPath) as! itemViewCollectionCell
        
        var items = Global.productInfo[indexPath.row]
        
        cell.image.image = Global.cardImages[indexPath.row]
        cell.title.text = items[0]
        cell.price.text = "قیمت: " + items[1]
        
        cell.add.setTitle("+", for: .normal)
        cell.add.addTarget(self, action: #selector(add), for: .touchUpInside)
        cell.add.tag = indexPath.row
        cell.minus.setTitle("-", for: .normal)
        cell.minus.addTarget(self, action: #selector(minus), for: .touchUpInside)
        cell.minus.tag = indexPath.row
        cell.count.text = String(productCount[indexPath.row])
        
        return cell
    }
    
    @objc func add(sender: UIButton) {
        productCount[sender.tag] += 1
        itemCollection.reloadData()
    }
    
    @objc func minus(sender: UIButton) {
        if productCount[sender.tag] > 1 {
            productCount[sender.tag] -= 1
            itemCollection.reloadData()
        } else {
            deleteItemIndex = sender.tag
            activateDeletePanel()
        }
    }
    
    func activateDeletePanel() {
        UIView.animate(withDuration: 0.2) {
            self.shadowPanel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    @objc func deleteItem() {
        UIView.animate(withDuration: 0.2) {
            self.shadowPanel.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    @objc func keepItem() {
        productCount[deleteItemIndex] = 1
        UIView.animate(withDuration: 0.2) {
            self.shadowPanel.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemCollection.frame.size.width, height: itemCollection.frame.size.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

class itemViewCollectionCell: UICollectionViewCell {
    var image: UIImageView!
    var title: UILabel!
    var price: UILabel!
    
    var add = UIButton()
    var minus = UIButton()
    var count = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        title.text = nil
        price.text = nil
        add.setTitle(nil, for: .normal)
        add.tag = 0
        minus.setTitle(nil, for: .normal)
        minus.tag = 0
        count.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: frame.width - frame.height, y: 0, width: frame.height, height: frame.height))
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        contentView.addSubview(image)
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width - frame.height - 10, height: frame.height / 2))
        title.textColor = UIColor.blue
        title.textAlignment = .right
        title.clipsToBounds = true
        title.layer.cornerRadius = 15
        contentView.addSubview(title)
        
        price = UILabel(frame: CGRect(x: 0, y: frame.height / 2, width: frame.width - frame.height - 10, height: frame.height / 2))
        price.textColor = UIColor.blue
        price.textAlignment = .right
        price.clipsToBounds = true
        price.layer.cornerRadius = 15
        contentView.addSubview(price)
        
        minus.frame = CGRect(x: 10, y: frame.height / 2 - 15, width: 30, height: 30)
        minus.backgroundColor = UIColor.red
        minus.layer.masksToBounds = true
        minus.layer.cornerRadius = 15
        minus.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        contentView.addSubview(minus)
        
        count.frame = CGRect(x: 40, y: frame.height / 2 - 15, width: 30, height: 30)
        count.textColor = UIColor.blue
        count.textAlignment = .center
        contentView.addSubview(count)
        
        add.frame = CGRect(x: 70, y: frame.height / 2 - 15, width: 30, height: 30)
        add.backgroundColor = UIColor.green
        add.layer.masksToBounds = true
        add.layer.cornerRadius = 15
        add.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        contentView.addSubview(add)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
