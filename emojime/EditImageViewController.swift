//
//  EditImageViewController.swift
//  emojime
//
//  Created by Billy on 05/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit

class EditImageViewController: UIViewController {
    open var imageArg:UIImage?

    //@IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var imageToEdit: UIImageView!
    
    @IBOutlet weak var EraseToolConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var CutBtn: UIButton!
    
    @IBOutlet weak var EraseBtn: UIButton!
    @IBOutlet weak var EraseToolView: EraseToolView!
    let tapRec = UITapGestureRecognizer()
    var firstPoint = CGPoint.zero
    var lastPoint = CGPoint.zero
    var red: CGFloat = 1.0
    var green: CGFloat = 1.0
    var blue: CGFloat = 1.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var cutoutBtnFlag = true
    var eraseToolOpened = false
    
    var aPath:UIBezierPath?
    var pathArray:NSMutableArray?
    var dic:NSMutableDictionary?
    
    @IBOutlet weak var smallPen: UIButton!
    @IBOutlet weak var normalPen: UIButton!
    @IBOutlet weak var mediumPen: UIButton!
    @IBOutlet weak var largePen: UIButton!
    
    let smallPenImg = UIImage(named: "Small")
    let normalPenImg = UIImage(named: "Normal")
    let mediumPenImg = UIImage(named: "Medium")
    let highPenImg = UIImage(named: "High")
    
    var tempImageArray: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageToEdit.image = imageArg
        self.title = "Edit Picture"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        tapRec.addTarget(self, action: #selector(EditImageViewController.tappedView))
        imageToEdit.backgroundColor = UIColor.clear
        imageToEdit.isOpaque = false
        //tempImageView.backgroundColor = UIColor.clear
        //tempImageView.isOpaque = false
        imageToEdit.isUserInteractionEnabled = true
        imageToEdit.addGestureRecognizer(tapRec)
        EraseToolView.layer.cornerRadius = 5
        EraseToolView.layer.masksToBounds = true
        EraseToolConstraint.constant = -43
        self.setEraseToolColor(small: true, normal: false, medium: false, large: false)
        
        let tempImage: UIImage = UIImage(cgImage: (self.imageArg?.cgImage)!, scale: (self.imageArg?.scale)!, orientation: (self.imageArg?.imageOrientation)!)
        tempImageArray.append(tempImage)
    }
    
    func setEraseToolColor(small: Bool, normal: Bool, medium: Bool, large: Bool) {
        var tintedImg = smallPenImg?.withRenderingMode(.alwaysTemplate)
        smallPen.setImage(tintedImg, for: .normal)
        if (small == true) {
            smallPen.tintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        } else {
            smallPen.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        tintedImg = normalPenImg?.withRenderingMode(.alwaysTemplate)
        normalPen.setImage(tintedImg, for: .normal)
        if (normal == true) {
            normalPen.tintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        } else {
            normalPen.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        tintedImg = mediumPenImg?.withRenderingMode(.alwaysTemplate)
        mediumPen.setImage(tintedImg, for: .normal)
        if (medium == true) {
            mediumPen.tintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        } else {
            mediumPen.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        tintedImg = highPenImg?.withRenderingMode(.alwaysTemplate)
        largePen.setImage(tintedImg, for: .normal)
        if (large == true) {
            largePen.tintColor = UIColor(red: 1, green: 66/255, blue: 2/255, alpha: 1.0)
        } else {
            largePen.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        
    }
    func randomStringWithLength (len : Int) -> NSString {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MMMM-HH-mm-ssZZZZZ"
        return dateFormatter.string(from: date as Date) as NSString
        /*
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        let sec = calendar.component(.nanosecond, from: date as Date)
        
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
 */
    }
    
    func getDocumentsDirectory() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = path[0]
        return documentDirectory as NSString
    }
    
    @IBAction func click_saveBtn(_ sender: Any) {
        let saveLocation = UIAlertController()
        let expressions = UIAlertAction(title: "Expressions", style: .default, handler: {(UIAlertAction) -> Void in
/*
            UIGraphicsBeginImageContextWithOptions(self.imageToEdit.getImageRectForImageView().size, self.imageToEdit.isOpaque, 0.0)
            self.imageToEdit.layer.render(in: UIGraphicsGetCurrentContext()!)
            let temp: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            UIGraphicsBeginImageContextWithOptions(self.imageToEdit.getImageRectForImageView().size, self.imageToEdit.isOpaque, 1.0)
            temp.draw(in: self.imageToEdit.bounds)
            let custom: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            let cgImge = custom.cgImage?.copy(maskingColorComponents: [0, 255, 0, 255, 0, 255])
            self.imageToEdit.image = UIImage(cgImage: cgImge!, scale: (self.imageToEdit.image?.scale)!, orientation: (self.imageToEdit.image?.imageOrientation)!)
*/
            UIGraphicsBeginImageContextWithOptions(self.imageToEdit.getImageRectForImageView().size, self.imageToEdit.isOpaque, 0.0)
            self.imageToEdit.layer.render(in: UIGraphicsGetCurrentContext()!)
            self.imageToEdit.image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            if let data = UIImageJPEGRepresentation(self.imageToEdit.image!, 1.0) {
                let fileName:String = "Expression-" + (self.randomStringWithLength(len: 10) as String) + ".jpeg"
                let fullPath:String = self.getDocumentsDirectory().appending("/").appending(fileName)
                try! data.write(to: URL(fileURLWithPath: fullPath), options: .atomic)
            }
            let myDelegate = UIApplication.shared.delegate as! AppDelegate
            myDelegate.changeRootTabController(tabIndex: 0)

            
        })
        let objects = UIAlertAction(title: "Objects", style: .default, handler: {(UIAlertAction) -> Void in
            UIGraphicsBeginImageContextWithOptions(self.imageToEdit.getImageRectForImageView().size, self.imageToEdit.isOpaque, 0.0)
            self.imageToEdit.layer.render(in: UIGraphicsGetCurrentContext()!)
            self.imageToEdit.image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            if let data = UIImageJPEGRepresentation(self.imageToEdit.image!, 1.0) {
                let fileName:String = "Object-" + (self.randomStringWithLength(len: 10) as String) + ".jpeg"
                let fullPath:String = self.getDocumentsDirectory().appending("/").appending(fileName)
                try! data.write(to: URL(fileURLWithPath: fullPath), options: .atomic)
            }
            let myDelegate = UIApplication.shared.delegate as! AppDelegate
            myDelegate.changeRootTabController(tabIndex: 1)

            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(UIAlertAction) -> Void in
            
        })
        saveLocation.addAction(expressions)
        saveLocation.addAction(objects)
        saveLocation.addAction(cancel)
        self.present(saveLocation, animated: true, completion: nil)
    }
    
    
    @IBAction func click_closeBtn(_ sender: Any) {
        let myDelegate = UIApplication.shared.delegate as! AppDelegate
        myDelegate.changeRootTabController(tabIndex: 2)
    }
    
    @IBAction func click_smallPen(_ sender: Any) {
        brushWidth = 10.0
        eraseToolOpened = false
        cutoutBtnFlag = false
        EraseToolConstraint.constant = -43
        self.setEraseToolColor(small: true, normal: false, medium: false, large: false)
    }
    @IBAction func click_normalPen(_ sender: Any) {
        brushWidth = 20.0
        eraseToolOpened = false
        cutoutBtnFlag = false
        EraseToolConstraint.constant = -43
        self.setEraseToolColor(small: false, normal: true, medium: false, large: false)
    }
    @IBAction func click_mediumPen(_ sender: Any) {
        brushWidth = 30.0
        eraseToolOpened = false
        cutoutBtnFlag = false
        EraseToolConstraint.constant = -43
        self.setEraseToolColor(small: false, normal: false, medium: true, large: false)
    }
    
    @IBAction func click_LargePen(_ sender: Any) {
        brushWidth = 40.0
        eraseToolOpened = false
        cutoutBtnFlag = false
        EraseToolConstraint.constant = -43
        self.setEraseToolColor(small: false, normal: false, medium: false, large: true)

    }
    @IBAction func click_eraseBtn(_ sender: Any) {
        cutoutBtnFlag = false
        if (eraseToolOpened == false) {
            eraseToolOpened = true
            EraseToolConstraint.constant = 0
        } else {
            eraseToolOpened = false
            EraseToolConstraint.constant = -43
        }
    }
    
    @IBAction func click_cutBtn(_ sender: Any) {
        cutoutBtnFlag = true
    }
    @IBAction func click_undoBtn(_ sender: Any) {
        if (tempImageArray.count == 0) {
            return
        }
        if (self.imageToEdit.layer.mask != nil) {
            self.imageToEdit.layer.mask = nil
        }
        self.imageToEdit.image = self.tempImageArray.last
        if (tempImageArray.count > 1) {
            tempImageArray.remove(at: tempImageArray.count - 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (cutoutBtnFlag == true) {
            if let touch = touches.first {
                aPath = UIBezierPath()
              
                if (self.imageToEdit.frame.contains(touch.location(in: self.imageToEdit))) {
                    aPath?.move(to: touch.location(in: self.imageToEdit))
                    firstPoint = touch.location(in: self.imageToEdit)
                    lastPoint = touch.location(in: self.imageToEdit)
                    let tempImage: UIImage = UIImage(cgImage: (self.imageToEdit.image?.cgImage)!, scale: (self.imageToEdit.image?.scale)!, orientation: (self.imageToEdit.image?.imageOrientation)!)
                    tempImageArray.append(tempImage)

                } else {
                    return
                }
            }
        } else {
            swiped = false
            if let touch = touches.first {
                lastPoint = touch.location(in: self.imageToEdit)
                let tempImage: UIImage = UIImage(cgImage: (self.imageToEdit.image?.cgImage)!, scale: (self.imageToEdit.image?.scale)!, orientation: (self.imageToEdit.image?.imageOrientation)!)
                tempImageArray.append(tempImage)

            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (cutoutBtnFlag == true) {
            if let touch = touches.first {
                //aPath = UIBezierPath()
                aPath?.addLine(to: touch.location(in: self.imageToEdit))
                let currentPoint = touch.location(in: self.imageToEdit)
                drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
        } else {
            swiped = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: self.imageToEdit)
                drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (cutoutBtnFlag == true) {
            if let touch = touches.first {
                if (self.imageToEdit.frame.contains(touch.location(in: self.imageToEdit))) {
                    aPath?.addLine(to: touch.location(in: self.imageToEdit))
                    aPath?.close()
                } else {
                    return
                }
            }
            drawLineFrom(fromPoint: firstPoint, toPoint: lastPoint)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = aPath?.cgPath
            maskLayer.frame = self.imageToEdit.frame
            maskLayer.fillColor = UIColor.white.cgColor
            maskLayer.backgroundColor = UIColor.clear.cgColor
            self.imageToEdit.layer.mask = maskLayer
            UIGraphicsBeginImageContext(self.imageToEdit.frame.size)
            self.imageToEdit.layer.render(in: UIGraphicsGetCurrentContext()!)
            
            self.imageToEdit.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            //let tempImage: UIImage = UIImage(cgImage: (self.imageToEdit.image?.cgImage)!, scale: (self.imageToEdit.image?.scale)!, orientation: (self.imageToEdit.image?.imageOrientation)!)
            //tempImageArray.append(tempImage)
            
        } else {
            if !swiped {
                drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
            }
            
            UIGraphicsBeginImageContext(self.imageToEdit.frame.size)
            self.imageToEdit.image?.draw(in: self.imageToEdit.getImageRectForImageView(), blendMode: .normal, alpha: 1.0)
            self.imageToEdit.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            //let tempImage: UIImage = UIImage(cgImage: (self.imageToEdit.image?.cgImage)!, scale: (self.imageToEdit.image?.scale)!, orientation: (self.imageToEdit.image?.imageOrientation)!)
            //tempImageArray.append(tempImage)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.imageToEdit.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.imageToEdit.image?.draw(in: self.imageToEdit.getImageRectForImageView(), blendMode: .normal, alpha: 1.0)
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        if (cutoutBtnFlag == true) {
            context?.setLineJoin(.miter)
            context?.setLineCap(.butt)
            context?.setLineWidth(5)
        } else {
            context?.setLineCap(.round)
            context?.setLineWidth(brushWidth)
        }
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setBlendMode(.normal)
        context?.strokePath()
        self.imageToEdit.image = UIGraphicsGetImageFromCurrentImageContext()
        self.imageToEdit.alpha = opacity
        UIGraphicsEndImageContext()
    }
    func tappedView() {
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

extension UIImageView {
    func getImageRectForImageView() -> CGRect {
        let imgViewSize: CGSize = self.frame.size
        let imgSize: CGSize = (self.image?.size)!
        
        let scaleW: CGFloat = imgViewSize.width / imgSize.width
        let scaleH: CGFloat = imgViewSize.height / imgSize.height
        let aspect: CGFloat = fmin(scaleW, scaleH)
        var imageRect = CGRect(x: 0, y: 0, width: imgSize.width * aspect, height: imgSize.height * aspect)
        imageRect.origin.x = (imgViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imgViewSize.height - imageRect.size.height) / 2
        imageRect.origin.x += self.frame.origin.x
        imageRect.origin.y += self.frame.origin.y
        return imageRect
    }
}
