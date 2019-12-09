//
//  ListDetailViewControllerTableViewController.swift
//  missionExample
//
//  Created by user on 2019/12/9.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate {
    func listDetailViewControllerDidCancel(controller:ListDetailViewController)
    func listDetailViewController(controller:ListDetailViewController, FinishAddingChecklist checklist:Checklist)
    func listDetailViewController(controller:ListDetailViewController, FinishEditingChecklist checklist:Checklist)
}

class ListDetailViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var delegate:ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (checklistToEdit != nil) {
            self.title = "Edit Checklist"
            textField.text = checklistToEdit?.name
            doneButton.isEnabled = true
        }
        textField.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.listDetailViewControllerDidCancel(controller: self)
    }
    
    @IBAction func done(_ sender: Any) {
        if (self.checklistToEdit == nil) {
            let checklist = Checklist(name: textField.text!)
            delegate?.listDetailViewController(controller: self, FinishAddingChecklist: checklist)
        } else {
            checklistToEdit?.name = self.textField.text!
            delegate?.listDetailViewController(controller: self, FinishEditingChecklist: checklistToEdit!)
        }
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
