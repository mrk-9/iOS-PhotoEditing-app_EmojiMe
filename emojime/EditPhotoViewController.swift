//
//  EditPhotoViewController.swift
//  emojime
//
//  Created by Billy on 04/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit
import MMSCropView
class EditPhotoViewController: UIViewController {
    open var imageArg:UIImage?
    @IBOutlet weak var imageToCrop: MMSCropView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Crop Image"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        imageToCrop.image = imageArg
    }
    
    @IBAction func click_CropDone(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editImageVC = storyBoard.instantiateViewController(withIdentifier: "EditImageViewController") as! EditImageViewController
        editImageVC.imageArg = imageToCrop.crop()
        self.present(editImageVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(editImageVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
