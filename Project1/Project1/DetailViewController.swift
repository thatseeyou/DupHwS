//
//  DetailViewController.swift
//  Project1
//
//  Created by Oh Sang Young on 2015. 12. 2..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // CHANGE POINT
    @IBOutlet weak var detailImageView: UIImageView!

    var imageFileName: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        // CHANGE POINT
        if let imageFileName = self.imageFileName {
            if let detailImageView = self.detailImageView {
                detailImageView.image = UIImage(named: imageFileName)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

