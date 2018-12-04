//
//  ViewController.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 10/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        button.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
//        button.setTitle("Tap To Login", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        view.addSubview(button)
//        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        button.translatesAutoresizingMaskIntoConstraints = false
        
        let accountButton = UIBarButtonItem(image: UIImage(named: "icon_account"), style: .plain, target: self, action: #selector(accountIconTapped))
        navigationItem.rightBarButtonItem = accountButton
        
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
    }
    
    @objc func accountIconTapped() {
        let settingsVc = SettingsViewController()
        let nav = UINavigationController(rootViewController: settingsVc)
        present(nav, animated: true, completion: nil)
    }

}

