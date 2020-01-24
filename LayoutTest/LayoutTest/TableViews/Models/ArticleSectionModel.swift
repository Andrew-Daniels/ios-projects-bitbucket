//
//  ArticleModel.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

struct ArticleSectionModel {
    var sectionName: String!
    var articles: [ArticleModel]
}

struct ArticleModel {
    var articleName: String!
    var articleSubscriberCount: Int!
    var articleImage: UIImage!
}
