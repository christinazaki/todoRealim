//
//  Category.swift
//  
//
//  Created by iMac on 10/27/19.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
}
