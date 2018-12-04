//
//  SettingsViewController.swift
//  FingerPrintWithACL
//
//  Created by Vinit Shanbhag on 03/12/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
        // Do any additional setup after loading the view.
        
        guard let configView = Bundle.main.loadNibNamed("LocalAuthenticationLoginConfigView", owner: self, options: nil)?.first as? LocalAuthenticationLoginConfigView else  {
            return
        }
        configView.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: 0)
        view.addSubview(configView)
        configView.clipsToBounds = true
        
    }

    @objc func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
