//
//  SettingOneTableViewCell.swift
//  emojime
//
//  Created by Billy on 08/01/17.
//  Copyright © 2017 So. All rights reserved.
//

import UIKit

class SettingOneTableViewCell: UITableViewCell {

    @IBOutlet weak var allDeleteL: UILabel!
    @IBOutlet weak var allDelete: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func click_DeleteAllEmojis(_ sender: Any) {
        print(self.allDelete.isOn)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
