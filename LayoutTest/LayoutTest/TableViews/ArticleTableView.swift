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
        
        articleSections =
        [
            ArticleSectionModel(sectionName: "Featured Articles", articles: [
                ArticleModel(articleName: "Lotus Focus", articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash"))]),
            ArticleSectionModel(sectionName: "Topics", articles: [
                ArticleModel(articleName: "Peace", articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash"))]),
            ArticleSectionModel(sectionName: "Time to Read", articles: [
                ArticleModel(articleName: "5 min", articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash"))])
        ]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articleSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleSections[section].articles.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tbvCellIdentifier) as! ArticleTableViewCell
        cell.articleSection = articleSections[indexPath.section]
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
