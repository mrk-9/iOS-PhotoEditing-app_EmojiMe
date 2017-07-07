//
//  TutorialOneViewController.swift
//  emojime
//
//  Created by Billy on 16/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit
import YSTutorialViewController

class TutorialOneViewController: UIViewController {
    let tutorialVC: YSTutorialViewController = YSTutorialViewController()
    var tutorialPages: [YSTutorialPageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tutorialVC.dataSource = self
        self.tutorialVC.delegate = self
        let page1: YSTutorialPageView = YSTutorialPageView(imageNamed: "tut1Image", bottomViewColor: UIColor.clear, iconNamed: "tut.png", title: "Stage 1", text: "Crop image close to size of desired emoji. Leave enough room to trace around your emoji in next step.")
        let page2: YSTutorialPageView = YSTutorialPageView(imageNamed: "tut2Image", bottomViewColor: UIColor.clear, iconNamed: "tut.png", title: "Stage 2", text: "Use your finger to trace around desired emoji. Come as close as possible connecting your line and not letting your finger leave the image for the tracing tool to work property.")
        let page3: YSTutorialPageView = YSTutorialPageView(imageNamed: "tut3Image", bottomViewColor: UIColor.clear, iconNamed: "tut.png", title: "Stage 3", text: "Use one of the four sized erasers to clean up edges of your new emoji.")
        let page4: YSTutorialPageView = YSTutorialPageView(imageNamed: "tut4Image", bottomViewColor: UIColor.clear, iconNamed: "tut.png", title: "Stage 4", text: "Save your new custom emoji in either the Expression or Objects folder.")
        self.tutorialPages.append(page1)
        self.tutorialPages.append(page2)
        self.tutorialPages.append(page3)
        self.tutorialPages.append(page4)
        
        self.tutorialVC.reload()
        self.view.addSubview(self.tutorialVC.view)

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
extension TutorialOneViewController: YSTutorialViewControllerDelegate, YSTutorialViewControllerDataSource {
    func numberOfPages(in viewController: YSTutorialViewController!) -> Int {
        return self.tutorialPages.count
        
    }
    func tutorialViewController(_ viewController: YSTutorialViewController!, tutorialPageViewFor index: Int) -> YSTutorialPageView! {
        return self.tutorialPages[index]
    }
    func tutorialViewControllerBackgroundImage(for index: Int) -> UIImage! {
        return UIImage(named: "tutImage.png")
    }
    func tutorialViewControllerDidPressedCloseButton(_ viewController: YSTutorialViewController!) {
        let myDelegate = UIApplication.shared.delegate as! AppDelegate
        myDelegate.changeRootTabController(tabIndex: 0)

    }
    func tutorialViewController(_ viewController: YSTutorialViewController!, didScrollToPageAt index: Int) {
        
    }
}

