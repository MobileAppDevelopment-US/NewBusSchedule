//
//  ScheduleViewController.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 23.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit
import Alamofire

class ScheduleViewController: UITableViewController {
    
    var arrayDictionaries = NSArray()
    var refresh = UIRefreshControl()
    //var manager = AFHTTPSessionManager()
    let identifierCell = "Cell"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createTableView()
        self.navigationItem.title = "Расписание автобусов"
        
        self.refresh = UIRefreshControl()
        
        self.refresh.addTarget(self, action: #selector(self.actionRefresh), for: .valueChanged)
        self.tableView.refreshControl = refresh
        
        self.tableView.register(CellFive.self, forCellReuseIdentifier: identifierCell) // I register a cell - I use CellFive to create cells

    }
    
    //MARK: - Action
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = InfoViewController()
        self.navigationController?.pushViewController(controller, animated: true)
        
        // записать в проперти controller.dictionatySchedule  массив
        
        }
        
    func actionRefresh() {
        
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)

        return cell
    }
    
    //height of the header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    //create a header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = CellFive(style: .default, reuseIdentifier: "header")
        
        headerCell.headerConfig()
        
        return headerCell
        
    }
    
    


}












