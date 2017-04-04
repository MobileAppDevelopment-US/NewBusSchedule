//
//  Localized.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 04.04.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit

extension String {
    
    //MARK: Localized
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        
    }
    
}

class Localized: NSObject {

}
