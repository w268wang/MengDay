//
//  MengDayCell.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit

class MengDayCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var patternView: UIView!
    @IBOutlet weak var patternNameLabel: UILabel!

    @IBOutlet var patternWidthConstraint: NSLayoutConstraint!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        patternView.backgroundColor = UIColor(patternImage: UIImage(named: "cellBackgroundPattern")!)
        patternNameLabel.textColor = UIColor.whiteColor()
    }
    
    func updateProgress(progress: Float) {
        patternWidthConstraint?.constant = CGFloat(progress) * frame.size.width
    }
}
