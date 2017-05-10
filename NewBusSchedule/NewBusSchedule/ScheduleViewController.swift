//
//  ScheduleViewController.swift
//  NewBusSchedule
//
//  Created by Serik Klement on 23.03.17.
//  Copyright © 2017 Serik Klement. All rights reserved.
//

import UIKit
import Alamofire

// the first time the application gets the data and saves it to the local database, with subsequent entries the data is displayed from the database, the data in the database is updated on the svaypu down in the list.
// when performing network operations, the interface is blocked and the user sees the wait dialog. If the server gives up an empty list, the user will see "Route list empty" in the middle of the screen. If the network operation fails, the user will see a message with a description of the problem and a "Repeat" button in the middle of the screen.

class ScheduleViewController: UITableViewController {
    
    var arrayDictionaries = NSArray()
    var refresh = UIRefreshControl()
    let userDefault = UserDefaults.standard
    var cellModelsArray = [SheldueCellModel]() // array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModelsArray = ((userDefault.object(forKey: "cellModelsArray") as? NSArray?)! ?? [String]() as NSArray) as! [SheldueCellModel]
        //cellModelsArray = (userDefault.object(forKey: cellModelsArray))
        
        if arrayDictionaries.count == 0 {  // isEmpty?
            
            loadData()
            
        } else {
            
            //dataFromLocalDatabase()
            
        }
        
        //createTableView()
        self.navigationItem.title = "ScheduleBas".localized
        
        refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(self.actionRefresh), for: .valueChanged)
        self.tableView.refreshControl = refresh

        
        registerCell()
        
    }
    
    func dataFromLocalDatabase() {
        
        self.tableView.reloadData()
        
        showAlert(withMessage: "UseDataLocalDatabase".localized,
                  andTitle: "Attention!".localized)
        
    }

    func loadData()  {
        
        addLockView()
        
        Alamofire.request("http://smartbus.gmoby.org/web/index.php/api/trips?from_date=20150101&to_date=20180301").responseJSON {
            response in
            
            if let result = response.result.value {
                
                let dictJSON = result as! NSDictionary
                
                if (dictJSON.count > 0) {
                    
                    self.arrayDictionaries = dictJSON.object(forKey: "data") as! NSArray
                    
                    self.createModels()
                    
                    self.refresh.endRefreshing()
                    
                    self.tableView.reloadData()
                    
                    //self.saveUserDefault()
                    
                    self.view.viewWithTag(1)?.removeFromSuperview()
                    
                    self.showAlert(withMessage: "ListUpdated".localized,
                                   andTitle: "")
                    
                } else {
                    
                    self.showAlert(withMessage: "ListEmpty".localized,
                                   andTitle: "Attention".localized)
                    
                }
                
            }
            
        }
        
    }
    
    func createModels() {
        
        for dict in self.arrayDictionaries {
            
            let cellModel = SheldueCellModel(withDictionary: dict as! NSDictionary)
            
            self.cellModelsArray.append(cellModel)
            
        }
        
    }
    
    func addLockView() {
        
        let view = UIView()
        view.frame = self.view.frame
        view.backgroundColor = UIColor.init(colorLiteralRed: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        view.tag = 1
        self.view.addSubview(view)
        
    }
    
    //MARK: - Action
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = InfoViewController()
        self.navigationController?.pushViewController(controller, animated: true)
        
        controller.cellInfoModel = cellModelsArray[indexPath.row]
        
    }
    
    func actionRefresh(_ sender: UIRefreshControl) {
        
        loadData()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModelsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! SheldueCell

        cell.sityLabel.text = cellModelsArray[indexPath.row].sity
        cell.fromDateLabel.text = cellModelsArray[indexPath.row].fromDate
        cell.fromTimeLabel.text = cellModelsArray[indexPath.row].fromTime
        cell.toDateLabel.text = cellModelsArray[indexPath.row].toDate
        cell.toTimeLabel.text = cellModelsArray[indexPath.row].toTime
        
        return cell
    }
    
    func registerCell() {
        
        self.tableView.register(SheldueCell.self, forCellReuseIdentifier: "MainCell") // I register a cell - I use SheldueCell to create cells
    }
    
    //height of the header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    //create a header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = SheldueCell(style: .default, reuseIdentifier: "header")
        
        headerCell.headerConfig()
        
        return headerCell
        
    }
    
    func showAlert(withMessage message: String, andTitle title: String) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertActionStyle.`default`,
                                      handler: nil))
        
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    
    func saveUserDefault() {
        
        userDefault.set(cellModelsArray, forKey: "cellModelsArray")
        
    }


}
    

