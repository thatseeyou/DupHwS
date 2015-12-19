//
//  P5TableViewController.swift
//  Project5
//
//  Created by Oh Sang Young on 2015. 12. 18..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit
import GameplayKit

class P5TableViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWordsFromDataAsset()
        newGame()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    func loadWordsFromDataAsset() {
        let dataAsset = NSDataAsset(name: "korwords")!

        let dataString = String(data: dataAsset.data, encoding: NSUTF8StringEncoding)!
        allWords = dataString.componentsSeparatedByString("\n")
    }

    func newGame()
    {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
    }

    @IBAction func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .Alert)

        // 1. add text field
        ac.addTextFieldWithConfigurationHandler() { (textField: UITextField) -> Void in
            textField.placeholder = "단어를 입력하세요"
        }

        // 2.
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, ac] (action: UIAlertAction!) in
            let answer = ac.textFields![0]
            self.submitAnswer(answer.text!)
        }
        ac.addAction(submitAction)

        // 3. presentViewController
        presentViewController(ac, animated: true, completion: nil)
    }

    func submitAnswer(answer: String) {
        let lowerAnswer = answer.lowercaseString

        let errorTitle: String
        let errorMessage: String

        if wordIsPossible(lowerAnswer) {
            if wordIsOriginal(lowerAnswer) {
                if wordIsReal(lowerAnswer) {
                    objects.insert(answer, atIndex: 0)

                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

                    return
                } else {
                    errorTitle = "스펠링검사 불합격"
                    errorMessage = "그런 단어 없는 것 같네요"
                }
            } else {
                errorTitle = "이미 추가된 답"
                errorMessage = "새로운 것을 생각해 보세요"
            }
        } else {
            errorTitle = "주어진 문제로부터 생성 불가"
            errorMessage = "'\(title!.lowercaseString)'에서 뽑아서 만들지 못 합니다!"
        }

        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }

    /**
     문제로 주어진 단어의 글자로 조합 가능한가?
    */
    func wordIsPossible(word: String) -> Bool {
        var tempWord = title!.lowercaseString

        for letter in word.characters {
            if let pos = tempWord.rangeOfString(String(letter)) {
                if pos.isEmpty {
                    return false
                } else {
                    tempWord.removeAtIndex(pos.startIndex)
                }
            } else {
                return false
            }
        }
        
        return true
    }

    /**
     이미 추가된 단어 인가?
    */
    func wordIsOriginal(word: String) -> Bool {
        return !objects.contains(word)
    }

    /**
     UITextChecker를 이용해서 스펠링검사 통과 여부 확인
    */
    func wordIsReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let misspelledRange = checker.rangeOfMisspelledWordInString(word, range: range, startingAt: 0, wrap: false, language: "ko_KR")
        
        return misspelledRange.location == NSNotFound
    }
}
