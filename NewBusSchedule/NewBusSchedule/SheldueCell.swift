//
//  SheldueCell.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 02.04.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit

class SheldueCell: UITableViewCell {
    
    var sityLabel: UILabel! // Announced that such a variable would be
    var fromDateLabel: UILabel!
    var fromTimeLabel: UILabel!
    var toDateLabel: UILabel!
    var toTimeLabel: UILabel!
    
    var space: CGFloat? // I create a variable
    var widthSityLabel: CGFloat?
    var widthOtherLabel: CGFloat?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sityLabel = createLabel()
        sityLabel.textAlignment = .center
        sityLabel.numberOfLines = 0
        sityLabel.lineBreakMode = .byWordWrapping
        fromDateLabel = createLabel()
        fromDateLabel.textAlignment = .center
        fromTimeLabel = createLabel()
        fromTimeLabel.textAlignment = .center
        toDateLabel = createLabel()
        toDateLabel.textAlignment = .center
        toTimeLabel = createLabel()
        toTimeLabel.textAlignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfig() {
        
        self.backgroundColor = UIColor.init(colorLiteralRed: 215.0/255, green: 211.0/255, blue: 213.0/255, alpha: 1)
        
        let font = "Baskerville-Bold"
        let sizeFont: CGFloat = 18
        
        sityLabel.text = "Schedule".localized
        sityLabel.font = UIFont(name: font, size: sizeFont)
        fromDateLabel.text = "FromDate".localized
        fromDateLabel.numberOfLines = 0
        fromDateLabel.lineBreakMode = .byWordWrapping
        fromDateLabel.font = UIFont(name: font, size: sizeFont)
        fromTimeLabel.text = "FromTime".localized
        fromTimeLabel.numberOfLines = 0
        fromTimeLabel.lineBreakMode = .byWordWrapping
        fromTimeLabel.font = UIFont(name: font, size: sizeFont)
        toDateLabel.text = "ToDate".localized
        toDateLabel.numberOfLines = 0
        toDateLabel.lineBreakMode = .byWordWrapping
        toDateLabel.font = UIFont(name: font, size: sizeFont)
        toTimeLabel.text = "ToTime".localized
        toTimeLabel.numberOfLines = 0
        toTimeLabel.lineBreakMode = .byWordWrapping
        toTimeLabel.font = UIFont(name: font, size: sizeFont)
        
    }
    
    func createLabel() -> UILabel {
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: CGFloat(UIScreen.main.bounds.size.width * 0.3), height: self.frame.size.height)
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        label.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(label)
        
        return label
        
    }
    
    func setWidthLabels() {
        
        space = 3
        widthSityLabel = UIScreen.main.bounds.size.width * 0.3
        widthOtherLabel = ((UIScreen.main.bounds.size.width - widthSityLabel!) - space! * 4) / 4
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        setWidthLabels()
        
        sityLabel.frame = CGRect(x: 0, y: 0, width: widthSityLabel!, height: self.frame.size.height)
        fromDateLabel.frame = CGRect(x: sityLabel.frame.size.width + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        fromTimeLabel.frame = CGRect(x: fromDateLabel.frame.size.width + fromDateLabel.frame.origin.x + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        toDateLabel.frame = CGRect(x: fromTimeLabel.frame.size.width + fromTimeLabel.frame.origin.x + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        toTimeLabel.frame = CGRect(x: toDateLabel.frame.size.width + toDateLabel.frame.origin.x + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        
    }
    
    
}
