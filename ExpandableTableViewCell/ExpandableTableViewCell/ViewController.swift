//
//  ViewController.swift
//  ExpandableTableViewCell
//
//  Created by Vinit Shanbhag on 29/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = -1
    var dataArray: [[String: String]] = [
        ["FirstName" : "Vinit", "LastName": "Shanbhag"],
        ["FirstName" : "Narayan", "LastName": "Shanbhag"],
        ["FirstName": "Usha", "LastName" : "Shanbhag"],
        ["FirstName" : "Poornima", "LastName" : "Shanbhag"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Mark : - TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row {
            return 100
        } else {
            return 40
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomCell else {
            return UITableViewCell.init()
        }
        let arrayEntry = dataArray[indexPath.row]
        cell.firstViewLabel.text = arrayEntry["FirstName"]
        cell.secondViewLabel.text = arrayEntry["LastName"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedIndex == indexPath.row {
//            selectedIndex = -1
//        } else {
//            selectedIndex = indexPath.row
//        }
        selectedIndex = indexPath.row
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

