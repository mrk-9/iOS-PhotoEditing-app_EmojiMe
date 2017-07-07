//
//  TermsViewController.swift
//  emojime
//
//  Created by Billy on 08/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    @IBOutlet weak var TermsTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Terms and Conditions"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        let fileURLProject = Bundle.main.path(forResource: "Terms", ofType: "txt")
        var terms = ""
        do {
            terms = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        do {
            let str = try NSAttributedString(data: terms.data(using: .unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            self.TermsTV.attributedText = str
        } catch let error as NSError {
            self.TermsTV.text = "None"
            print(error)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
