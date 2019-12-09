//
//  ViewController.swift
//  missionExample
//
//  Created by user on 2019/12/6.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MainController: UITableViewController, MainListControllerDelegate {
    
    var checklist:Checklist?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.checklist?.name
    }
    // 設定check選取
    func configgureCheckmarkCell(cell:UITableViewCell, item:MainItem){
        let label = cell.viewWithTag(1001) as! UILabel
        if (item.checked!) {
            label.text = "✓"
        } else {
            label.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist!.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as UITableViewCell
        // 取得cell內的label
        let item = checklist?.items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item!.text
        configgureCheckmarkCell(cell: cell, item: item!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取得點擊的cell
        let cell = tableView.cellForRow(at: indexPath)
        let item = checklist?.items[indexPath.row]
        item!.toggleChecked()
        configgureCheckmarkCell(cell: cell!, item: item!)
        // 取消當前cell選取狀態
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //刪除資料
        checklist!.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        // 通知視圖刪除的資料同時顯示刪除動畫
        tableView.deleteRows(at: indexPaths, with: UITableView.RowAnimation.automatic)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueStr = "\(segue.identifier!)"
        if (segueStr == "AddItem") {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! MainListController
            controller.delegate = self
        } else if (segueStr == "EditItem") {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! MainListController
            controller.delegate = self
            let indexPath = self.tableView.indexPath(for: sender! as! UITableViewCell)
            controller.itemToEdit = checklist!.items[indexPath!.row]
        }
    }
    
    func addItem(controller: MainListController, didFinishAddingItem item: MainItem) {
        // 取得新資料的索引
        let newRowIndex = checklist!.items.count
        // 將資料加入資料來源
        checklist!.items.append(item)
        // 透過新資料的索引獲得indexPath
        let indexPath = NSIndexPath(row: newRowIndex, section: 0)
        // 根據insertRowsAtIndexPaths的參數需求將indexPath放入一個陣列中
        let indexPaths = [indexPath]
        //通知視圖有新增資料
        self.tableView.insertRows(at: indexPaths as [IndexPath], with: UITableView.RowAnimation.automatic)
        // 關閉目前的頁面
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addItem(controller: MainListController, didFinishEditingItem item: MainItem) {
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func addItemDidCancel(controller: MainListController) {
         controller.dismiss(animated: true, completion: nil)
    }
    
}

