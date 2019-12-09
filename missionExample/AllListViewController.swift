//
//  AllListViewController.swift
//  missionExample
//
//  Created by user on 2019/12/9.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AllListViewController: UITableViewController, ListDetailViewControllerDelegate {

    var dataModel:DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onCreateDate()
        loadChecklistItems()
    }
    
    func onCreateDate(){
        for i in 0...4 {
            let item = Checklist(name:"任務類別:\(i)")
            dataModel!.lists.append(item)
        }
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  dataModel!.lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        // cell重用機制
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = dataModel!.lists[indexPath.row].name
        cell!.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowChecklist", sender:dataModel!.lists[indexPath.row])
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete the row from the data source
        // 刪除資料要把lists所屬資料刪除
        dataModel!.lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        dataModel!.saveCheckLists()
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let navgationController = self.storyboard!.instantiateViewController(identifier: "ListNavigationController") as! UINavigationController
        let controller = navigationController?.topViewController as! ListDetailViewController
        controller.delegate = self
        // 取得選取行資料
        let checklist = dataModel!.lists[indexPath.row]
        // 傳遞行資料
        controller.checklistToEdit = checklist
        // 切換介面
        self.present(navgationController, animated: true, completion: nil)
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
        PathString.append(contentsOf: "Checklists.plist")
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
            dataModel!.lists = unarchiver.decodeObject(forKey: "Checklist") as! Array
            // 結束解碼
            unarchiver.finishDecoding()
        } else {
            // 找不到就建立一個
            dataModel!.saveCheckLists()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowChecklist") {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! MainController
            controller.checklist = sender as? Checklist
        } else if (segue.identifier == "AddChecklist") {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! MainListController
            controller.delegate = (self as! MainListControllerDelegate)
            controller.itemToEdit = nil
        }
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        self.dismiss(animated: true, completion: nil)
    }

    func listDetailViewController(controller: ListDetailViewController, FinishAddingChecklist checklist: Checklist) {
        let newRowIndex = dataModel!.lists.count
        dataModel!.lists.append(checklist)
        let indexPath = NSIndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        self.tableView.insertRows(at: indexPaths as [IndexPath], with: UITableView.RowAnimation.automatic)
        self.dismiss(animated: true, completion: nil)
        dataModel!.saveCheckLists()
    }

    func listDetailViewController(controller: ListDetailViewController, FinishEditingChecklist checklist: Checklist) {
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        dataModel!.saveCheckLists()
    }
}
