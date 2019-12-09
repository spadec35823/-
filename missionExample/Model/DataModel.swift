//
//  DataModel.swift
//  missionExample
//
//  Created by user on 2019/12/9.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var lists = [Checklist]()
    override init() {
        super.init()
    }
    // 儲存資料檔案
    func saveCheckLists(){
        let data = NSMutableData()
        // 宣告一個歸檔處理物件
        var archiver = NSKeyedArchiver(forWritingWith: data)
        // 將list以對應Checklist關鍵字進行編碼
        archiver.encode(lists, forKey: "Checklist")
        // 編碼結束
        archiver.finishEncoding()
        // 資料寫入
        data.write(toFile: dataFilePath(), atomically: true)
    }
    // 取得沙盒路徑
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory:String = paths.first!
        return documentsDirectory
    }
    // 取得資料檔案地址
    func dataFilePath() -> String {
        var PathString:String = self.documentsDirectory()
        PathString.append(contentsOf: "Checklist.plist")
        return PathString
    }
    // 讀取本地資料
    func loadChecklistItems() {
        // 取得本地資料檔案位置
        let path = self.dataFilePath()
        // 宣告檔案管理員
        let defaultManager = FileManager()
        // 透過檔案地址判斷檔案是否存在
        if (defaultManager.fileExists(atPath: path)){
            // 讀取本地檔案資料
            let data = NSData(contentsOfFile: path)
            // 解碼
            let unarchiver = try! NSKeyedUnarchiver(forReadingWith: data! as Data)
       
            // 透過歸檔時設定的關鍵字ChecklistItems還原arrData
            lists = unarchiver.decodeObject(forKey: "Checklist") as! Array
            // 結束解碼
            unarchiver.finishDecoding()
            print("第一次建立\(lists.count)")
        } else {
            // 找不到就建立一個
            let checklist = Checklist(name: "第一個任務類型")
            lists.append(checklist)
            saveCheckLists()
        }
    }
}
