//
//  Checklist.swift
//  missionExample
//
//  Created by user on 2019/12/9.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class Checklist: NSObject , NSCoding {
    var name:String = ""
    var items = [MainItem]()
    
    init(name:String) {
        self.name = name
    }
    // 從object解碼回來
    required init(coder aDecoder:NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "Name") as! String
        self.items = aDecoder.decodeObject(forKey: "Items") as! [MainItem]
    }
    // 編碼成object
    func encode(with coder: NSCoder) {
        coder.encode(self.name as NSObject, forKey: "Name")
        coder.encode(self.items as NSObject, forKey: "Items")
    }
}
