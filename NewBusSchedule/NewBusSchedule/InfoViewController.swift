//
//  InfoViewController.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 24.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {
    
    var dictionarySchedule: NSDictionary?
    var arrayNamesRows: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayNamesRows = ["FlightNumber".localized,
                          "Schedule".localized,
                          "FromDate".localized,
                          "FromTime".localized,
                          "ToDate".localized,
                          "ToTime".localized,
                          "TicketPrice".localized,
                          "ReservedPlaces".localized]
        
        self.navigationItem.title = "FlightInformation".localized
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (arrayNamesRows?.count)!
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CallLogViewCell")
        
        if cell == nil {
            
            cell = UITableViewCell(style: .value1, reuseIdentifier: "CallLogViewCell")
            
        }
        
        cell?.textLabel?.text = arrayNamesRows?.object(at: indexPath.row) as! String?
        
        var integerNum: Int?
        
        switch (indexPath.row) {
            
        case 0:
            integerNum = dictionarySchedule?.object(forKey: "bus_id") as? Int
            cell?.detailTextLabel?.text = String(format: "%zd", integerNum!)
        case 1:
            cell?.detailTextLabel?.text = dictionarySchedule?.object(forKey: "info") as? String
            cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell?.detailTextLabel?.numberOfLines = 2
        case 2:
            cell?.detailTextLabel?.text = dictionarySchedule?.object(forKey: "from_date") as? String
        case 3:
            cell?.detailTextLabel?.text = dictionarySchedule?.object(forKey: "from_time") as? String
        case 4:
            cell?.detailTextLabel?.text = dictionarySchedule?.object(forKey: "to_date") as? String
        case 5:
            cell?.detailTextLabel?.text = dictionarySchedule?.object(forKey: "to_time") as? String
        case 6:
            integerNum = dictionarySchedule?.object(forKey: "price") as? Int
            cell?.detailTextLabel?.text = String(format: "%zd", integerNum!)
        case 7:
            integerNum = dictionarySchedule?.object(forKey: "reservation_count") as? Int
            cell?.detailTextLabel?.text = String(format: "%zd", integerNum!)
            
        default:
            break
            
        }
        
        return cell!
    }
    
    
}
