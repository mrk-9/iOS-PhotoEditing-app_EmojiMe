//
//  SettingTableViewController.swift
//  emojime
//
//  Created by Billy on 05/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet var settingTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingOneTableViewCell", for: indexPath) as! SettingOneTableViewCell
            cell.allDeleteL.text = "Clear all emojis"
            cell.allDelete.isOn = false
            cell.allDelete.onTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
            cell.selectionStyle = .none
            return cell
        
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTwoTableViewCell", for: indexPath) as! SettingTwoTableViewCell
            cell.captionL.text = "Share app"
            cell.accessoryType = .disclosureIndicator
            return cell
            
        } else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTwoTableViewCell", for: indexPath) as! SettingTwoTableViewCell
            cell.captionL.text = "Terms & Conditions"
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTwoTableViewCell", for: indexPath) as! SettingTwoTableViewCell
            cell.captionL.text = "Rate this app"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        // Configure the cell...

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            var sharingItems = [AnyObject]()
            sharingItems.append(NSString(string: "I use Emoji Me"))
            sharingItems.append(NSURL(string: "http://www.soemojime.com")!)
            let activityVC = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
            
            
        } else if (indexPath.row == 2) {
            let termVC = self.storyboard?.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
            self.navigationController?.pushViewController(termVC, animated: true)
            
        } else {
            let rateVC = self.storyboard?.instantiateViewController(withIdentifier: "RateViewController") as! RateViewController
            self.navigationController?.pushViewController(rateVC, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
