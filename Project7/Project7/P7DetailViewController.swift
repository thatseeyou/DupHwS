//
//  DetailViewController.swift
//  Project7
//
//  Created by Oh Sang Young on 2015. 12. 28..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit
import WebKit

class P7DetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    var detailItem: [String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard detailItem != nil else { return }

        if let body = detailItem["body"] {
            textView.text = body
        }
    }

    deinit {
        logTrace()
    }
}


