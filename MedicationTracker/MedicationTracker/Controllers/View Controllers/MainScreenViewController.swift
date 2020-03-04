//
//  MainScreenViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit
import UserNotifications

class MainScreenViewController: UIViewController {
    
    var dayController = DayController()
    var itemController = ItemController()
    var groupController = GroupController()
    var alertManager = AlertManager()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        requestPermission()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainMenuSegue" {
            guard let mainMenuVC = segue.destination as? MainMenuViewController else { fatalError("Segue to MainMenu failed.") }
            
            mainMenuVC.dayController = self.dayController
            mainMenuVC.itemController = self.itemController
            mainMenuVC.groupController = self.groupController
            mainMenuVC.alertManager = self.alertManager
        }
        
    }
    
    // MARK: - Notifications Functionality
    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: .alert) { (granted, error) in
            if granted {
                print("Access Granted")
            } else {
                print("D'oh!")
            }
        }
    }
    
    
    
    
}


// MARK: - Table View Methods

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupController.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainViewCell") as? MainScreenTableViewCell else { fatalError("Could not convert items to cells") }
        
        cell.identifier = groupController.groups[indexPath.row]
        
        
        return cell
    }
  
}
