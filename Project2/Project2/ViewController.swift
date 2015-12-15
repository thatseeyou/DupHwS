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
    @IBOutlet var flagButtons: [UIButton]!

    let numExample = 3
    var answer = 0
    var score = 0
    var numTry = 0

    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    var motionEffectGroup = [UIMotionEffectGroup]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        addMotionEffect()

        newQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addMotionEffect() {
        for i in 0..<numExample {
            let xAxis = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
            @IBOutlet weak var progressView: UIProgressView!
            @IBOutlet weak var progressView: UIProgressView!
            @IBOutlet weak var progressView: UIProgressView!
            xAxis.minimumRelativeValue = 0.0
            xAxis.maximumRelativeValue = 0.0

            let yAxis = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
            yAxis.minimumRelativeValue = 0.0
            yAxis.maximumRelativeValue = 0.0

            let group = UIMotionEffectGroup()
            group.motionEffects = [xAxis, yAxis]

            motionEffectGroup += [group]

            flagButtons[i].addMotionEffect(group)
        }
    }

    func updateMotionEffect(answer: Int) {
        for i in 0..<numExample {
            for j in 0...1 {
                (motionEffectGroup[i].motionEffects![j] as! UIInterpolatingMotionEffect).minimumRelativeValue = (i != answer) ? 0.0 : -40
                (motionEffectGroup[i].motionEffects![j] as! UIInterpolatingMotionEffect).maximumRelativeValue = (i != answer) ? 0.0 : 40
            }
        }
    }

    func newQuestion(action: UIAlertAction? = nil) {
        @IBAction func openPressed(sender: UIBarButtonItem) {
        }
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]

        for i in 0..<numExample {
            assert(flagButtons[i].tag == i)
            flagButtons[i].setImage(UIImage(named: countries[i]), forState: .Normal)
        }

        answer = GKRandomSource.sharedRandom().nextIntWithUpperBound(numExample)
        title = countries[answer].uppercaseString

        updateMotionEffect(answer)
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

