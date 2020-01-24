//
//  CellSizedByObject.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/21/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

protocol CellSizedByObject {
    associatedtype Element
    
    static func getSizeForCell(withObject: Element) -> CGSize
}
