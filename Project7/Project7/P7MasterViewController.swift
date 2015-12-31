//
//  MasterViewController.swift
//  Project7
//
//  Created by Oh Sang Young on 2015. 12. 28..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

class P7MasterViewController: UITableViewController {

    var objects = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if navigationController?.tabBarItem.tag == 0 {
            navigationItem.title = "Most Recent"
        } else {
            navigationItem.title = "Top Rated"
        }

        loadJSON()
    }

    override func viewWillAppear(animated: Bool) {
        logTrace()

        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed

        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if tableView.indexPathForSelectedRow != nil {
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! P7DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["body"]
        return cell
    }


    // MARK: - HTTP
    func loadJSON() {
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=30"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=30"
        }

        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {

                if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) {
                    if let status = json["metadata"]??["responseInfo"]??["status"] as? Int {
                        if status != 200 {
                            showError("status code \(status)")
                        }
                        else {
                            print(status)
                            parseJSON(json)
                        }
                    }
                    else {
                        showError("No status code")
                    }
                }
                else {
                    showError("JSON parsing error")
                }
            } else {
                showError("HTTP 실패")
            }
        } else {
            showError("URL 생성 실패")
        }

    }

    func parseJSON(json: AnyObject) {
        guard let results = json["results"] as? [AnyObject] else { return }

        for result in results {
            //print(result)

            var obj = [String:String]()

            if let title = result["title"] as? String {
                obj["title"] = title
            }
            if let body = result["body"] as? String {
                obj["body"] = body
            }
            if let signatureCount = result["signatureCount"] as? Int {
                obj["signatureCount"] = "\(signatureCount)"
            }

            objects.append(obj)
        }

        //print(objects)

        tableView.reloadData()
    }

    func showError(msg:String) {
        let ac = UIAlertController(title: "Loading error", message: msg, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
}

