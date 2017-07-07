//
//  ExpressionViewController.swift
//  emojime
//
//  Created by Billy on 04/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit
import GRKImageCrop
class ExpressionViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var presetCollectionView: UICollectionView!
    @IBOutlet weak var expressionLibCollectionView: UICollectionView!
    
    @IBOutlet weak var expPresetCV: UICollectionView!
    @IBOutlet weak var expLibCV: UICollectionView!
    var pngFiles: [URL] = []
    var preSetFiles: [String] = []
    var pngFileNames: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Expressions"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //self.tabBarController?.tabBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.tabBarController?.tabBar.frame.size.width = self.view.frame.width + 4
        self.tabBarController?.tabBar.frame.origin.x = -2
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl!, includingPropertiesForKeys: nil, options: [])
            let pngFiles = directoryContents.filter{ $0.pathExtension == "jpeg" && $0.absoluteString.contains("Expression") }
            print(pngFiles)
            self.pngFileNames = pngFiles.map{ $0.deletingPathExtension().lastPathComponent }
            self.pngFiles = pngFiles
            print(pngFileNames)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        expressionLibCollectionView.reloadData()
        presetCollectionView.reloadData()
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

extension ExpressionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.expPresetCV) {
            return 25
        } else {
            return pngFiles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.expPresetCV) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PresetCollectionViewCell", for: indexPath) as! PresetCollectionViewCell
            cell.imageView.image = UIImage(named: "image" + "\(indexPath.row+1)" + ".png")
            self.preSetFiles.append("image" + "\(indexPath.row+1)" + ".png")
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpLibraryCollectionViewCell", for: indexPath) as! ExpLibraryCollectionViewCell
            let imgData: NSData = try! NSData.init(contentsOf: pngFiles[indexPath.row].absoluteURL)
            let img: UIImage = UIImage.init(data: imgData as Data)!
            let cgImge = img.cgImage?.copy(maskingColorComponents: [222, 255, 222, 255, 222, 255])
            let imageToCrop = UIImage(cgImage: cgImge!, scale: (img.scale), orientation: (img.imageOrientation))
            imageToCrop.cropImage(belowAlphaThreshold: 0.0, completion: {(croppedImage, error) -> Void in
                cell.imageView.image = croppedImage
            })
            return cell
        }
    }
    
    func removeImage(itemName: String, fileExtension: String) {
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func showOptionMenu(optionType: Bool, shareImage: UIImage, deleteIndex: Int) {
        let saveLocation = UIAlertController()
        var sharingItems = [AnyObject]()
        let pngImage = UIImagePNGRepresentation(shareImage)
        sharingItems.append(pngImage as AnyObject)
        let activityVC = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        //activityVC.init
        //(activityItems: sharingItems, applicationActivities: nil)
        let expressions = UIAlertAction(title: "Message", style: .default, handler: {(UIAlertAction) -> Void in
            self.present(activityVC, animated: true, completion: nil)
        })
        saveLocation.addAction(expressions)
        let objects = UIAlertAction(title: "Mail", style: .default, handler: {(UIAlertAction) -> Void in
            self.present(activityVC, animated: true, completion: nil)
        })
        saveLocation.addAction(objects)
        let copy = UIAlertAction(title: "Copy", style: .default, handler: {(UIAlertAction) -> Void in
            UIPasteboard.general.image = shareImage
        })
        saveLocation.addAction(copy)
        if (optionType == true) {
            let delete = UIAlertAction(title: "Delete", style: .default, handler: {(UIAlertAction) -> Void in
                
                let confirmAlert = UIAlertController(title: "Confirm", message: "Would you like to remove this emoji?", preferredStyle: .alert)
                let ok = UIKit.UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                    self.removeImage(itemName: self.pngFileNames[deleteIndex], fileExtension: "jpeg")
                    let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                    do {
                        let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl!, includingPropertiesForKeys: nil, options: [])
                        let pngFiles = directoryContents.filter{ $0.pathExtension == "jpeg" && $0.absoluteString.contains("Expression") }
                        self.pngFileNames = pngFiles.map{ $0.deletingPathExtension().lastPathComponent }
                        self.pngFiles = pngFiles
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                    self.expressionLibCollectionView.reloadData()
                    self.expressionLibCollectionView.layoutIfNeeded()
                })
                let cancel = UIKit.UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
                confirmAlert.addAction(ok)
                confirmAlert.addAction(cancel)
                self.present(confirmAlert, animated: true, completion: nil)
            })
            saveLocation.addAction(delete)
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) -> Void in
            
        })
        
        saveLocation.addAction(cancel)
        self.present(saveLocation, animated: true, completion: nil)

    }
    
    func scaledToWidth(sourceImage: UIImage, i_width: CGFloat) -> UIImage {
        let oldWidth: CGFloat = sourceImage.size.width
        print(oldWidth)
        print(sourceImage.size.height)
        let scaleFactor: CGFloat = i_width / oldWidth
        let newHeight: CGFloat = sourceImage.size.height * scaleFactor
        let newWidth: CGFloat = oldWidth * scaleFactor
        print(newHeight)
        print(newWidth)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    func addShadow(image: UIImage, blurSize: CGFloat = 20.0) -> UIImage {
        
        let shadowColor = UIColor(white:1.0, alpha:0.8).cgColor
        
        let context = CGContext(data: nil,
                                width: Int(image.size.width + blurSize * 3),
                                height: Int(image.size.height + blurSize * 3),
                                bitsPerComponent: image.cgImage!.bitsPerComponent,
                                bytesPerRow: 0,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        context.setShadow(offset: CGSize(width: 0,height: 0),
                          blur: blurSize,
                          color: shadowColor)
        context.draw(image.cgImage!,
                     in: CGRect(x: blurSize, y: blurSize, width: image.size.width, height: image.size.height),
                     byTiling:false)
        
        return UIImage(cgImage: context.makeImage()!)
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.expPresetCV) {
            let cell = collectionView.cellForItem(at: indexPath) as! PresetCollectionViewCell
            let img: UIImage = self.addShadow(image: cell.imageView.image!)
            let resizedImg = self.resizeImage(image: img, targetSize: CGSize(width: 100, height: 150))
            self.showOptionMenu(optionType: false, shareImage: resizedImg, deleteIndex: 0)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ExpLibraryCollectionViewCell
            let img: UIImage = self.addShadow(image: cell.imageView.image!)
            self.showOptionMenu(optionType: true, shareImage: self.resizeImage(image: img, targetSize: CGSize(width: 100, height: 150)), deleteIndex: indexPath.row)
        }
    }
}
