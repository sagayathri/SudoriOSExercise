//
//  HouseTableViewCell.swift
//  SudorExercise
//
//  Created by Myah Technologies on 17/01/2020.
//  Copyright © 2020 Gayathri Arumugam. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var houseLogo: UIImageView!
    @IBOutlet weak var houseName: UILabel!
    
    var name = ""
    
    var house: House? {
        didSet {
            name = house!.name
            self.SetUpUI()
        }
    }
    
    func SetUpUI() {
        cellView.layer.shadowRadius = 3.0
        cellView.layer.shadowColor = UIColor(named: "SudorYellow")?.cgColor;
        cellView.layer.shadowOpacity = 1.0
        cellView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
       
        houseName.contentMode = .scaleToFill
        
        //MARK:- Removes House from name
        if let range = name.range(of: "House ") {
            self.name.removeSubrange(range)
            self.houseName.text = name
            self.imageView?.image = UIImage(named: name)
        }
    }
}
