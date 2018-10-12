//
//  ReaderViewController.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 5/17/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import UIKit

class ReaderViewController: UIViewController {

    @IBOutlet weak var readTextView: UITextView!
    @IBOutlet weak var readerSlider: UISlider!
   
    @IBOutlet weak var containerView: UIView!
    
    private var isReading: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 20.0
        readTextView.isEditable = false
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public init(chapterId: Int) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @IBAction func clickedPreviousButton(_ sender: UIButton) {
    }
    @IBAction func clickedPlayPauseButton(_ sender: UIButton) {
        if isReading {
            //Stop Reading
            print("Stop Reading")
            sender.setImage(#imageLiteral(resourceName: "icons8-Circled Play_50"), for: .normal)
        } else {
            //Start Reading
            print("Start Reading")
            sender.setImage(#imageLiteral(resourceName: "icons8-Pause Button_50"), for: .normal)
        }
        isReading = !isReading
    }
    @IBAction func clickedNextPreviousButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func clickedFavouriteButton(_ sender: UIButton) {
    }
    required init?(coder aDecoder: NSCoder) {
       
        fatalError("init(coder:) has not been implemented")
    }
}
