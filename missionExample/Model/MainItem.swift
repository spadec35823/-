//
//  MainItem.swift
//  missionExample
//
//  Created by user on 2019/12/6.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MainItem: NSObject {
    // cell標題
    var text:String?
    // cell選取屬性
    var checked:Bool?
    
    init(text:String, checked:Bool){
        self.text = text
        self.checked = checked
    }
    // 選取屬性反轉
    func toggleChecked(){
        self.checked = !self.checked!
    }
}
