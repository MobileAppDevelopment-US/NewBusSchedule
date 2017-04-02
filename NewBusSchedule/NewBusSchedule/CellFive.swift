//
//  CellFive.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 23.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit

extension String {
    
    //MARK: Localized
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        
    }
    
}

class CellFive: UITableViewCell {
    
    var sityLabel: UILabel! // Announced that such a variable would be
    var dateFromLabel: UILabel!
    var timeFromLabel: UILabel!
    var dateToLabel: UILabel!
    var timeToLabel: UILabel!
    
    var space: CGFloat? // I create a variable
    var widthSityLabel: CGFloat?
    var widthOtherLabel: CGFloat?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sityLabel = createLabel()
        sityLabel.textAlignment = .center
        sityLabel.numberOfLines = 0
        sityLabel.lineBreakMode = .byWordWrapping
        dateFromLabel = createLabel()
        dateFromLabel.textAlignment = .center
        timeFromLabel = createLabel()
        timeFromLabel.textAlignment = .center
        dateToLabel = createLabel()
        dateToLabel.textAlignment = .center
        timeToLabel = createLabel()
        timeToLabel.textAlignment = .center
        
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
        dateFromLabel.text = "FromDate".localized
        dateFromLabel.numberOfLines = 0
        dateFromLabel.lineBreakMode = .byWordWrapping
        dateFromLabel.font = UIFont(name: font, size: sizeFont)
        timeFromLabel.text = "FromTime".localized
        timeFromLabel.numberOfLines = 0
        timeFromLabel.lineBreakMode = .byWordWrapping
        timeFromLabel.font = UIFont(name: font, size: sizeFont)
        dateToLabel.text = "ToDate".localized
        dateToLabel.numberOfLines = 0
        dateToLabel.lineBreakMode = .byWordWrapping
        dateToLabel.font = UIFont(name: font, size: sizeFont)
        timeToLabel.text = "ToTime".localized
        timeToLabel.numberOfLines = 0
        timeToLabel.lineBreakMode = .byWordWrapping
        timeToLabel.font = UIFont(name: font, size: sizeFont)
        
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
        dateFromLabel.frame = CGRect(x: sityLabel.frame.size.width + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        timeFromLabel.frame = CGRect(x: dateFromLabel.frame.size.width + dateFromLabel.frame.origin.x + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        dateToLabel.frame = CGRect(x: timeFromLabel.frame.size.width + timeFromLabel.frame.origin.x + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        timeToLabel.frame = CGRect(x: dateToLabel.frame.size.width + dateToLabel.frame.origin.x + space!, y: 0, width: widthOtherLabel!, height: self.frame.size.height)
        
    }
    
    
}
