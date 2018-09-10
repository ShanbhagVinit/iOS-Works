//
//  DetailViewController.swift
//  Collaborate_2
//
//  Created by Vinit Shanbhag on 09/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var profileViewOne: ProfileView!
    @IBOutlet weak var profileViewTwo: ProfileView!
    @IBOutlet weak var profileViewThree: ProfileView!
    @IBOutlet weak var profileViewFour: ProfileView!
    @IBOutlet weak var profileViewFive: ProfileView!
    @IBOutlet weak var profileViewSix: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileViewOne.networkImage = #imageLiteral(resourceName: "CompactFacebook")
        self.profileViewTwo.networkImage = #imageLiteral(resourceName: "CompactGitHub")
        self.profileViewThree.networkImage = #imageLiteral(resourceName: "CompactMedium")
        self.profileViewFour.networkImage = #imageLiteral(resourceName: "CompactTwitter")
        self.profileViewFive.networkImage = #imageLiteral(resourceName: "CompactLinkedIn")
        self.profileViewSix.networkImage = #imageLiteral(resourceName: "CompactStackOverflow")
        
        // Do any additional setup after loading the view.
    }

}
