//
//  DailyViewController.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {

    @IBOutlet weak var articlesCollectionView: WordScrollCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        articlesCollectionView.articleSection =
            ArticleSectionModel(sectionName: "Featured Articles", articles: [
                ArticleModel(articleName: "Lotus Focus", articleSubscriberCount: 5, articleImage: UIImage(named: "erol-ahmed-aIYFR0vbADk-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleSubscriberCount: 444, articleImage: UIImage(named: "harli-marten-n7a2OJDSZns-unsplash")),
                ArticleModel(articleName: "Peace", articleSubscriberCount: 133, articleImage: UIImage(named: "sean-kong--1B_y4wGs-s-unsplash")),
                ArticleModel(articleName: "Balance", articleSubscriberCount: 12345, articleImage: UIImage(named: "bekir-donmez-eofm5R5f9Kw-unsplash")),
                ArticleModel(articleName: "5 min", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "10 min", articleSubscriberCount: 615, articleImage: UIImage(named: "brooke-cagle-4rgGY-Aa308-unsplash")),
                ArticleModel(articleName: "Peaceful Thoughts: How to", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "Meet the Dodgers", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "We can't play", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "People say what they want", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "Bring it on Tommy!", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "Do you think you can?", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "I think so", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "I pick my nose", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "Just kidding", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "But seriously", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "Is this working", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "Probably not", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash")),
                ArticleModel(articleName: "But it's ok", articleSubscriberCount: 32165, articleImage: UIImage(named: "verne-ho-BTfDOQLPHlc-unsplash"))])
    }
}
