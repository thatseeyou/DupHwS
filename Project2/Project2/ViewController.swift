//
//  ViewController.swift
//  Project2
//
//  Created by Oh Sang Young on 2015. 12. 2..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    let numExample = 3
    var answer = 0
    var score = 0
    var numTry = 0

    @IBOutlet var flagButtons: [UIButton]!
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        newQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newQuestion(action: UIAlertAction? = nil) {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]

        for i in 0..<numExample {
            assert(flagButtons[i].tag == i)
            flagButtons[i].setImage(UIImage(named: countries[i]), forState: .Normal)
        }

        answer = GKRandomSource.sharedRandom().nextIntWithUpperBound(numExample)
        title = countries[answer].uppercaseString
    }

    @IBAction func didSelectExample(sender: UIButton) {
        if answer == sender.tag {
            title = "Correct"
            score++
        }
        else {
            title = "Wrong"
        }
        numTry++

        let ac = UIAlertController(title: title, message: "Your score is \(score)/\(numTry).", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: newQuestion))
        presentViewController(ac, animated: true, completion: nil)
    }
}

