//
//  MainListController.swift
//  missionExample
//
//  Created by user on 2019/12/6.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

// 寫個代理協定 用於回呼
protocol MainListControllerDelegate {
    func addItemDidCancel(controller:MainListController)
    func addItem(controller:MainListController, didFinishAddingItem item:MainItem)
    func addItem(controller:MainListController, didFinishEditingItem item:MainItem)
}

class MainListController:UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    var delegate: MainListControllerDelegate?
    
    var itemToEdit: MainItem?
    
    override func viewDidLoad() {
        textField.delegate = self
        
        if (itemToEdit != nil) {
            self.title = "編輯任務"
            self.textField.text = itemToEdit?.text
            self.doneButton.isEnabled = true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        doneButton.isEnabled = textField.text!.count > 0
    }
    
    // 取消
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemDidCancel(controller: self)
    }
    // 完成
    @IBAction func done(_ sender: Any) {
        if (itemToEdit != nil) {
            self.itemToEdit?.text = self.textField.text
            delegate?.addItem(controller: self, didFinishEditingItem: self.itemToEdit!)
        } else {
            let item = MainItem(text: textField.text!, checked: false)
            delegate?.addItem(controller: self, didFinishAddingItem: item)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
}
