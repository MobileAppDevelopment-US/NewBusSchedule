//
//  InfoViewController.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 24.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit

class InfoViewController: UITableViewController {
    
    var cellInfoModel: SheldueCellModel?
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
                
        switch (indexPath.row) {
            
        case 0:
            cell?.detailTextLabel?.text = cellInfoModel?.busID
        case 1:
            cell?.detailTextLabel?.text = cellInfoModel?.info
            cell?.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell?.detailTextLabel?.numberOfLines = 2
        case 2:
            cell?.detailTextLabel?.text = cellInfoModel?.fromDate
        case 3:
            cell?.detailTextLabel?.text = cellInfoModel?.fromTime
        case 4:
            cell?.detailTextLabel?.text = cellInfoModel?.toDate
        case 5:
            cell?.detailTextLabel?.text = cellInfoModel?.toTime
        case 6:
            cell?.detailTextLabel?.text = cellInfoModel?.info
        case 7:
            cell?.detailTextLabel?.text = cellInfoModel?.reservationCount
            
        default:
            break
            
        }
        
        return cell!
    }
    
    
}
