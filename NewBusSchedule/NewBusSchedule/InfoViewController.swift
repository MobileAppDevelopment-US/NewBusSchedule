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
    let identifierCellInfo = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayNamesRows = ["Номер рейса",
                          "Маршрут",
                          "Дата отправления",
                          "Время отправления",
                          "Дата прибытия",
                          "Время прибытия",
                          "Стоимость билета",
                          "Зарезервировано мест"]
        
        self.navigationItem.title = "Информация о рейсе"

       self.tableView.register(CellFive.self, forCellReuseIdentifier: identifierCellInfo)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return (arrayNamesRows?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCellInfo, for: indexPath)
        
        // I assign a value from the array by index
        cell.textLabel?.text = arrayNamesRows?.object(at: indexPath.row) as! String?
        
        return cell
    }

    
 }
