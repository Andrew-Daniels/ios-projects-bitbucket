//
//  ArticleTableView.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class ArticleTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private let tbvCellIdentifier = "ArticleTBVCell"
    
    public var articleSections: [ArticleSectionModel]!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        
        self.rowHeight = self.frame.height / 3.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articleSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleSections[section].articles.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tbvCellIdentifier) as! ArticleTableViewCell
        let articleSection = articleSections[indexPath.section]
        cell.articleSection = articleSection
        cell.articleCollectionView.articleSection = articleSection
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        view.backgroundColor = UIColor(named: "PTWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = articleSections[section].sectionName
        
        let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 13)
        let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        view.addConstraints([leading, trailing, top, bottom])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
