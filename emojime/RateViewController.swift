//
//  RateViewController.swift
//  emojime
//
//  Created by Billy on 08/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    let YOUR_APP_STORE_ID = "1175651694"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rate This App"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func feedback_app(_ sender: Any) {
        if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL(string: "https://emojime.com")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "https://emojime.com")!)
        }
    }

    @IBAction func rate_app(_ sender: Any) {
        let iOS7AppStoreURLFormat: NSString = "itms-apps://itunes.apple.com/app/id1175651694"
        let iOSAppStoreURLFormat: NSString = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1175651694"
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: iOSAppStoreURLFormat as String)!, options: [:], completionHandler: nil)
         
        } else {
            UIApplication.shared.openURL(URL(string: iOS7AppStoreURLFormat as String)!)
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
