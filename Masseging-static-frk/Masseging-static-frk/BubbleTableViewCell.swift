//
//  BubbleTableViewCell.swift
//  Masseging-static-frk
//
//  Created by discussolutions on 9/14/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class BubbleTableViewCell: UITableViewCell {

    @IBOutlet var imgmasage: UIImageView!
    @IBOutlet var imgbottum: NSLayoutConstraint!
    
    @IBOutlet var lblTiming: UILabel!
    @IBOutlet var lblMassage: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
