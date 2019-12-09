//
//  MainItem.swift
//  missionExample
//
//  Created by user on 2019/12/6.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MainItem: NSObject, NSCoding {
    // cell標題
    var text:String? = ""
    // cell選取屬性
    var checked:Bool? = false
        
    // 構造方法
    init(text:String, checked:Bool){
        self.text = text
        self.checked = checked
    }
    // 從object解碼回來
    required init(coder aDecoder:NSCoder) {
        self.text = aDecoder.decodeObject(forKey: "Text") as? String
        self.checked = aDecoder.decodeObject(forKey: "Checked") as? Bool
    }
    // 編碼成object
    func encode(with coder: NSCoder) {
          coder.encode(self.text! as NSObject, forKey: "Text")
          coder.encode(self.checked! as NSObject, forKey: "Checked")
    }
    // 選取屬性反轉
    func toggleChecked(){
        self.checked = !self.checked!
    }
}
