//
//  SheldueCellModel.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 02.04.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit

class SheldueCellModel: NSObject {
    
    var busID: String!
    var sity: String!
    var fromDate: String!
    var fromTime: String!
    var toDate: String!
    var toTime: String!
    var price: String!
    var reservationCount: String!
    var info: String!

    
    init(withDictionary: NSDictionary) {
        
        let dictFromCity: NSDictionary = withDictionary.object(forKey: "from_city") as! NSDictionary
        let fromCity: String = dictFromCity.object(forKey: "name") as! String
        let dictToCity: NSDictionary = withDictionary.object(forKey: "to_city") as! NSDictionary
        let toCity: String = dictToCity.object(forKey: "name") as! String
        let cityes = fromCity + " - " + toCity
        
        var integerNum: Int?
        
        sity = cityes
        fromDate = withDictionary.object(forKey: "from_date") as! String
        fromTime = withDictionary.object(forKey: "from_time") as! String
        toDate = withDictionary.object(forKey: "to_date") as! String
        toTime = withDictionary.object(forKey: "to_time") as! String
        info = withDictionary.object(forKey: "info") as! String
        
        integerNum = withDictionary.object(forKey: "bus_id") as? Int
        busID = String(format: "%zd", integerNum!)
        
        integerNum = withDictionary.object(forKey: "price") as? Int
        price = String(format: "%zd", integerNum!)
        
        integerNum = withDictionary.object(forKey: "reservation_count") as? Int
        reservationCount = String(format: "%zd", integerNum!)
        
    }


}
