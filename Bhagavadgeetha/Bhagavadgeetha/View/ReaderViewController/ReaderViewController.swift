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
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var nextButton: UIButton!
    
    private var currentIndex: Int = 0 {
        didSet {
            if currentIndex < readerPresenter.numberOfQuotes() && currentIndex >= 0 {
                setUpLabelText()
                setupNextButtonState()
                setUpBackButtonState()
                readTextView.text = readerPresenter.getQuote(for: currentIndex)
            }
        }
    }
    private var isReading: Bool = false
    private let readerPresenter: ReaderViewPresenterType = ReaderViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readTextView.layer.cornerRadius = 20.0
        self.title = "Quotes"
        let rightBarButtonItem = UIBarButtonItem.init(title: "Share", style: .plain, target: self, action: #selector(didTapShare))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        readTextView.text = readerPresenter.getQuote(for: 0)
        setUpLabelText()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public init(chapterId: Int) {
        super.init(nibName: nil, bundle: nil)
        readerPresenter.setUpChapterID(chapterId)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLabelText() {
        indexLabel.text = "\(currentIndex + 1) / \(readerPresenter.numberOfQuotes())"
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    @IBAction func clickedNextButton(_ sender: UIButton) {
        if currentIndex < readerPresenter.numberOfQuotes() {
            currentIndex += 1
        }
    }

    @objc private func didTapShare() {
        let controller = UIAlertController.init(title: "Share Options", message: "Share this Quote on Social Apps", preferredStyle: .actionSheet)
        let fbShareAction = UIAlertAction(title: "FaceBook", style: .default) { (action) in

        }
        fbShareAction.setValue(UIImage(named: "Facebook-filled"), forKey: "image")
        let twitterShareAction = UIAlertAction(title: "Twitter", style: .default) { (action) in

        }
        twitterShareAction.setValue(UIImage(named: "Twitter-filled"), forKey: "image")
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(fbShareAction)
        controller.addAction(twitterShareAction)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: nil)
        
    }
    
    private func setupNextButtonState() {
        if currentIndex >= readerPresenter.numberOfQuotes() {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }
    }
    
    private func setUpBackButtonState() {
        if currentIndex < 0 {
            backButton.isEnabled = false
            backButton.alpha = 0.5
        } else {
            backButton.isEnabled = true
            backButton.alpha = 1.0
        }
    }
    
}
