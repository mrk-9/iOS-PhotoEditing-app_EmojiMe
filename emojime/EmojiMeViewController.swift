//
//  EmojiMeViewController.swift
//  emojime
//
//  Created by Billy on 04/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit
import TOCropViewController
class EmojiMeViewController: UIViewController {

    @IBOutlet weak var cameraRollBtn: UIButton!
    @IBOutlet weak var takePictureBtn: UIButton!
    //var imageToCrop: UIImage! = nil
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Emoji Me"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        cameraRollBtn.layer.cornerRadius = 5
        cameraRollBtn.layer.borderWidth = 1
        cameraRollBtn.layer.borderColor = UIColor.black.cgColor
        takePictureBtn.layer.cornerRadius = 5
        takePictureBtn.layer.borderWidth = 1
        takePictureBtn.layer.borderColor = UIColor.black.cgColor
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
    @IBAction func Click_CameraRoll(_ sender: Any) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        self.imagePicker.delegate = self
        
    }

    @IBAction func Click_TakePicture(_ sender: Any) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .camera
        self.imagePicker.cameraCaptureMode = .photo
        self.imagePicker.delegate = self
        self.present(self.imagePicker, animated: true, completion: nil)
    }
}
extension EmojiMeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageToCrop: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cropView: TOCropViewController = TOCropViewController(image: imageToCrop)
        //cropView.title = "Crop Image"
        //let titleView: UIView = UIView()
        //titleView.frame.size = CGSize(width: 50, height: 50)
        //cropView.navigationController?.navigationBar.addSubview(titleView)
        //cropView.navigationController?.navigationBar.layer.zPosition = 10
        //cropView.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        //cropView.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        cropView.delegate = self
        picker.dismiss(animated: true, completion: {
            self.present(cropView, animated: true, completion: nil)
        })
    }
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        //let myDelegate = UIApplication.shared.delegate as! AppDelegate
        //myDelegate.changeRootController(image)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editImageVC = storyBoard.instantiateViewController(withIdentifier: "EditImageViewController") as! EditImageViewController
        editImageVC.imageArg = image
        self.dismiss(animated: true, completion: {
            self.present(editImageVC, animated: true, completion: nil)
        })
    }
}
