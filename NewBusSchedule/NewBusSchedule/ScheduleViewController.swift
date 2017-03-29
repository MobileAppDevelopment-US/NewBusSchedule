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
    let identifierCellSchedule = "Cell"
    let userDefault = UserDefaults.standard
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrayDictionaries = (userDefault.object(forKey: "arrayDictionaries") as? NSArray?)! ?? [String]() as NSArray
        
        if self.arrayDictionaries.count == 0 {  // isEmpty
            
            loadData()
            
        } else {
            
            
            
        }




        loadData()
        
        //createTableView()
        self.navigationItem.title = "Расписание автобусов"
        
        self.refresh = UIRefreshControl()
        
        self.refresh.addTarget(self, action: #selector(self.actionRefresh), for: .valueChanged)
        self.tableView.refreshControl = refresh
        
        self.tableView.register(CellFive.self, forCellReuseIdentifier: identifierCellSchedule) // I register a cell - I use CellFive to create cells

    }
    
    
    
    func dataFromLocalDatabase() {
        
        self.tableView.reloadData()
        
        //showAllert(withMessage: "Вы используете данные из локальной базы. Пожалуйста обновите данные!", andTitle: "ВНИМАНИЕ!")
        

    }
    
    func loadData()  {
        
        addLockView()
        
        Alamofire.request("http://smartbus.gmoby.org/web/index.php/api/trips?from_date=20150101&to_date=20180301").responseJSON {
            response in
            
            if let result = response.result.value {
                
                let JSON = result as! NSDictionary
                
                self.arrayDictionaries = JSON.object(forKey: "data") as! NSArray
                
            }
            
        }
        
            self.view.viewWithTag(1)?.removeFromSuperview()
            
            //there must be allert
            
            self.refresh.endRefreshing()
            
            self.tableView.reloadData()

            //there must be save data
            
            //there must be bloks
            
            //var myDict:NSDictionary = ["Data" : myArrayOfDict] // массив  в  словарь

        
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
        
        controller.dictionarySchedule = self.arrayDictionaries[indexPath.row] as? NSDictionary
        
    }

    
    func actionRefresh(_ sender: UIRefreshControl) {
        
        loadData()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCellSchedule, for: indexPath) as! CellFive
        
    //let dic: NSDictionary = self.arrayDictionaries.object(at: indexPath.row) as! NSDictionary
        //let dic: [AnyHashable: Any]? = (arrayDictionaries[indexPath.row] as? [AnyHashable: Any])

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
                                      handler: nil)) // ? nil -  верно?
        
        self.navigationController?.present(alert, animated: true, completion: nil) // вместо nil{ _ in }
    
    }
    
    func saveUserDefault() {
        
        //let userDefault = UserDefaults.standard

        self.userDefault.set(arrayDictionaries, forKey: "arrayDictionaries")
        
    }
    
    
}
