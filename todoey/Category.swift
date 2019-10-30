//
//  Category.swift
//  
//
//  Created by iMac on 10/27/19.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name : String = ""
     let items = List<Item>()
}
