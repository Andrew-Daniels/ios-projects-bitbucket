//
//  HomeViewController.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var articlesTableView: ArticleTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesTableView.articleSections =
        [
            ArticleSectionModel(sectionName: "Featured Articles", articles: [
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 5, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash")),
                ArticleModel(articleName: "Peace", articleSubscriberCount: 15, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 15, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "5 min", articleSubscriberCount: 15, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 15, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash"))]),
            ArticleSectionModel(sectionName: "Topics", articles: [
                ArticleModel(articleName: "Peace", articleSubscriberCount: 15, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 15, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "5 min", articleSubscriberCount: 15, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 15, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash")),
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 15, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleSubscriberCount: 15, articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash"))]),
            ArticleSectionModel(sectionName: "Time to Read", articles: [
                ArticleModel(articleName: "5 min", articleSubscriberCount: 15, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 15, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash")),
                ArticleModel(articleName: "Peace", articleSubscriberCount: 15, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 15, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 15, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash"))]),
            ArticleSectionModel(sectionName: "Time to Read", articles: [
                ArticleModel(articleName: "5 min", articleSubscriberCount: 15, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 15, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash")),
                ArticleModel(articleName: "Peace", articleSubscriberCount: 15, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 15, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 15, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash"))]),
            ArticleSectionModel(sectionName: "Time to Read", articles: [
                ArticleModel(articleName: "5 min", articleSubscriberCount: 15, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 15, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash")),
                ArticleModel(articleName: "Peace", articleSubscriberCount: 15, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 15, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 15, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash"))]),
            ArticleSectionModel(sectionName: "Time to Read", articles: [
                ArticleModel(articleName: "5 min", articleSubscriberCount: 15, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 15, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash")),
                ArticleModel(articleName: "Peace", articleSubscriberCount: 15, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 15, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 15, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleSubscriberCount: 15, articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash"))])
        ]
    }
}
