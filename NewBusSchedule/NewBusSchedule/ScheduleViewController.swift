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
    let userDefault = UserDefaults.standard
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayDictionaries = (userDefault.object(forKey: "arrayDictionaries") as? NSArray?)! ?? [String]() as NSArray
        
        if arrayDictionaries.count == 0 {  // isEmpty?
            
            loadData()
            
        } else {
            
            dataFromLocalDatabase()
            
        }
        
        //createTableView()
        self.navigationItem.title = "ScheduleBas".localized
        
        refresh = UIRefreshControl()
        
        refresh.addTarget(self, action: #selector(self.actionRefresh), for: .valueChanged)
        self.tableView.refreshControl = refresh
        
        self.tableView.register(CellFive.self, forCellReuseIdentifier: "MainCell") // I register a cell - I use CellFive to create cells
        
    }
    
    func dataFromLocalDatabase() {
        
        self.tableView.reloadData()
        
        showAlert(withMessage: "Вы используете данные из локальной базы. Пожалуйста обновите данные!",
                  andTitle: "ВНИМАНИЕ!")
        
    }
    
    func loadData()  {
        
        addLockView()
        
        Alamofire.request("http://smartbus.gmoby.org/web/index.php/api/trips?from_date=20150101&to_date=20180301").responseJSON {
            response in
            
            if let result = response.result.value {
                
                let dictJSON = result as! NSDictionary
                
                if (dictJSON.count > 0) {
                    
                    self.arrayDictionaries = dictJSON.object(forKey: "data") as! NSArray
                    
                    self.refresh.endRefreshing()
                    
                    self.tableView.reloadData()
                    
                    self.saveUserDefault()
                    
                    self.view.viewWithTag(1)?.removeFromSuperview()
                    
                    self.showAlert(withMessage: "Список маршрутов обновлен",
                                   andTitle: "")
                    
                } else {
                    
                    self.showAlert(withMessage: "Список маршрутов пуст",
                                   andTitle: "ВНИМАНИЕ")
                    
                }
                
            }
            
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
        
        controller.dictionarySchedule = arrayDictionaries.object(at:indexPath.row) as? NSDictionary 
        
    }
    
    func actionRefresh(_ sender: UIRefreshControl) {
        
        loadData()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayDictionaries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! CellFive
        
        let dict: NSDictionary = arrayDictionaries.object(at:indexPath.row) as! NSDictionary
        
        let dictFromCity: NSDictionary = dict.object(forKey: "from_city") as! NSDictionary
        let fromCity: String = dictFromCity.object(forKey: "name") as! String
        
        let dictToCity: NSDictionary = dict.object(forKey: "to_city") as! NSDictionary
        let toCity: String = dictToCity.object(forKey: "name") as! String
        
        let cityes = fromCity + " - " + toCity
        
        let fromDate: String = dict.object(forKey: "from_date") as! String
        let fromTime: String = dict.object(forKey: "from_time") as! String
        let toDate: String = dict.object(forKey: "to_date") as! String
        let toTime: String = dict.object(forKey: "to_time") as! String
        
        cell.sityLabel.text = cityes
        cell.dateFromLabel.text = fromDate
        cell.timeFromLabel.text = fromTime
        cell.dateToLabel.text = toDate
        cell.timeToLabel.text = toTime
        
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
        
        userDefault.set(arrayDictionaries, forKey: "arrayDictionaries")
        
    }
    
    
}
