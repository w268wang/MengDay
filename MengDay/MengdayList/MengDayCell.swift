//
//  MengDayCell.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit

class MengDayCell: UITableViewCell {
    
    let nameLabel: UILabel
    let birthdayLabel: UILabel
    
    let patternView: UIView
    let patternNameLabel: UILabel
    
    var patternWidthConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFontOfSize(30)
        
        birthdayLabel = UILabel()
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        patternView = UIView()
        patternView.translatesAutoresizingMaskIntoConstraints = false
        patternView.clipsToBounds = true
        
        patternNameLabel = UILabel()
        patternNameLabel.translatesAutoresizingMaskIntoConstraints = false
        patternNameLabel.font = nameLabel.font
        patternNameLabel.textColor = .whiteColor()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        patternView.backgroundColor = UIColor(patternImage: UIImage(named: "cellBackgroundPattern")!)
        
        addSubview(nameLabel)
        addSubview(birthdayLabel)
        addSubview(patternView)
        patternView.addSubview(patternNameLabel)
        
        let views = ["pattern": patternView, "name": nameLabel, "birthday": birthdayLabel]
        var layoutConstraints = [NSLayoutConstraint]()
        
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("|[pattern]", options: [], metrics: nil, views: views)
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[pattern]|", options: [], metrics: nil, views: views)
        patternWidthConstraint = patternView.widthAnchor.constraintEqualToConstant(0)
        layoutConstraints.append(patternWidthConstraint!)
        layoutConstraints.append(nameLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        layoutConstraints.append(nameLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor))
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("[birthday]-|", options: [], metrics: nil, views: views)
        layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:[birthday]|", options: [], metrics: nil, views: views)
        
        // Adjust the position of the name mask
        layoutConstraints.append(patternNameLabel.leadingAnchor.constraintEqualToAnchor(nameLabel.leadingAnchor))
        layoutConstraints.append(patternNameLabel.centerYAnchor.constraintEqualToAnchor(nameLabel.centerYAnchor))
        
        NSLayoutConstraint.activateConstraints(layoutConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateProgress(progress: Float) {
        patternWidthConstraint?.constant = CGFloat(progress)*frame.size.width
    }
}
