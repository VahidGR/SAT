//
//  Charts.swift
//  SAT
//
//  Created by Vahid Ghanbarpour on 11/18/18.
//  Copyright © 2018 Vahid Ghanbarpour. All rights reserved.
//

import UIKit

class Charts: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var scrollView: UIScrollView!
    var chartsCount = 3
    
    var chartValueCount = [3, 5, 4]
    var chartIndex = [[25, 40, 60], [35, 50, 55, 60, 40], [35, 50, 55, 60]]
    
    var chartsCollection: UICollectionView!
    var logsTable: UITableView!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        let subviews = self.view.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: (UIApplication.shared.statusBarView?.frame.size.height)! + (navigationController?.navigationBar.frame.size.height)!, width: view.frame.size.width, height: view.frame.size.height - (UIApplication.shared.statusBarView?.frame.size.height)! - (navigationController?.navigationBar.frame.size.height)!))
        view.addSubview(scrollView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        chartsCollection = UICollectionView(frame: CGRect(x: 0, y: 50, width: scrollView.frame.size.width, height: scrollView.frame.size.height / 4), collectionViewLayout: flowLayout)
        chartsCollection.register(chartsCell.self, forCellWithReuseIdentifier: "chartsCell")
        chartsCollection.delegate = self
        chartsCollection.dataSource = self
        chartsCollection.backgroundColor = UIColor.clear
        chartsCollection.showsVerticalScrollIndicator = false
        chartsCollection.showsHorizontalScrollIndicator = false
        scrollView.addSubview(chartsCollection)
        
        logsTable = UITableView(frame: CGRect(x: view.frame.size.width / 10, y: chartsCollection.frame.origin.y + chartsCollection.frame.size.height + 120, width: view.frame.size.width * 8 / 10, height: view.frame.size.height - (chartsCollection.frame.origin.y + chartsCollection.frame.size.height + 20)))
        logsTable.register(logCell.self, forCellReuseIdentifier: "logCell")
        logsTable.delegate = self
        logsTable.dataSource = self
        view.addSubview(logsTable)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chartsCell", for: indexPath) as! chartsCell
        cell.chartValueCount = chartValueCount[indexPath.row]
        cell.chartIndex = chartIndex[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: scrollView.frame.size.width * 2 / 3, height: scrollView.frame.size.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! logCell
        cell.title.text = "عنوان"
        cell.result.text = "%83"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

class chartsCell: UICollectionViewCell {
    
    var lines = [UIImageView]()
    var descriptions = [UILabel]()
    var indexView: UIView!
    var zero: UILabel!
    var oneForth: UILabel!
    var half: UILabel!
    var threeForth: UILabel!
    var full: UILabel!
    var chartIndex: [Int] {
        didSet {
            for i in 0 ..< chartValueCount {
                let line = UIImageView(frame: CGRect(x: frame.width * CGFloat(i + 1) / CGFloat(chartValueCount + 1) - (5 * CGFloat(i + 1)), y: frame.height / 100 * CGFloat(100 - (chartIndex[i])), width: 10, height: frame.height / 100 * CGFloat(chartIndex[i])))
                line.backgroundColor = UIColor.blue
                line.layer.masksToBounds = true
                line.layer.cornerRadius = 5
                lines.append(line)
                let description = UILabel(frame: CGRect(x: lines[i].frame.origin.x - 10, y: frame.height, width: 30, height: 20))
                description.font = UIFont.systemFont(ofSize: 12.0)
                description.textAlignment = .center
                description.textColor = UIColor.gray
                description.text = "%" + String(chartIndex[i])
                descriptions.append(description)
                
                contentView.addSubview(lines[i])
                contentView.addSubview(descriptions[i])
            }
        }
    }
    var chartValueCount: Int {
        didSet {
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lines.removeAll()
        descriptions.removeAll()
        chartValueCount = 0
        chartIndex.removeAll()
    }
    
    override init(frame: CGRect) {
        chartValueCount = Int()
        chartIndex = [Int]()
        super.init(frame: frame)
        
        indexView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        zero = UILabel(frame: CGRect(x: 0, y: frame.height - 20, width: 40, height: 40))
        zero.text = "0"
        zero.textAlignment = .center
        zero.textColor = UIColor.gray
        zero.font = UIFont.systemFont(ofSize: 12.0)
        indexView.addSubview(zero)
        oneForth = UILabel(frame: CGRect(x: 0, y: frame.height * 3 / 4 - 20, width: 40, height: 40))
        oneForth.text = "25"
        oneForth.textAlignment = .center
        oneForth.textColor = UIColor.gray
        oneForth.font = UIFont.systemFont(ofSize: 12.0)
        indexView.addSubview(oneForth)
        half = UILabel(frame: CGRect(x: 0, y: frame.height / 2 - 20, width: 40, height: 40))
        half.text = "50"
        half.textAlignment = .center
        half.textColor = UIColor.gray
        half.font = UIFont.systemFont(ofSize: 12.0)
        indexView.addSubview(half)
        threeForth = UILabel(frame: CGRect(x: 0, y: frame.height / 4 - 20, width: 40, height: 40))
        threeForth.text = "75"
        threeForth.textAlignment = .center
        threeForth.textColor = UIColor.gray
        threeForth.font = UIFont.systemFont(ofSize: 12.0)
        indexView.addSubview(threeForth)
        full = UILabel(frame: CGRect(x: 0, y: -20, width: 40, height: 40))
        full.text = "100"
        full.textAlignment = .center
        full.textColor = UIColor.gray
        full.font = UIFont.systemFont(ofSize: 12.0)
        indexView.addSubview(full)
        
        contentView.addSubview(indexView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class logCell: UITableViewCell {
    var title: UILabel!
    var result: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "logCell")
        
        title = UILabel(frame: CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height))
        title.textAlignment = .right
        title.textColor = UIColor.darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        result = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height))
        result.textAlignment = .left
        result.textColor = UIColor.darkGray
        result.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(result)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



