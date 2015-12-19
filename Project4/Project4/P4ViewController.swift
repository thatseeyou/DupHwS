//
//  ViewController.swift
//  Project4
//
//  Created by Oh Sang Young on 2015. 12. 12..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit
import WebKit

class P4ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var progressView: UIProgressView!

    var webView: WKWebView!
    let websites = ["apple.com", "hackingwithswift.com"]

    override func loadView() {
        // Method 1. Load manually WKWebView as view
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        logTrace()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Method 2. Show WKWebView as subview
        //addWebViewAsSubview()

        progressView.progress = 0.0
        progressView.translatesAutoresizingMaskIntoConstraints = false

        registerKVO()

        webView.allowsBackForwardNavigationGestures = true

        openPage(0);
    }

    override func viewWillAppear(animated: Bool) {
        logTrace()
        logDebug(progressView.description)
        logViewHierarchy()
    }
    
    override func viewDidAppear(animated: Bool) {
        logTrace()
        logDebug(progressView.description)
        logViewHierarchy()

        //print(progressView.superview)

        //
        // 수평, 수직 회전을 할 경우에 refresh 버튼이 눌리지 않는 문제가 발생해서 다음과 같이 해결했다.
        // progressView를 포함하고 있는 UIBarButtonItem 의 width도 0이 아닌 다른 값을 주었다.
        //
        if let toolbar = navigationController!.toolbar {
            progressView.centerYAnchor.constraintEqualToAnchor(toolbar.centerYAnchor).active = true
            progressView.leadingAnchor.constraintEqualToAnchor(toolbar.leadingAnchor, constant: 20.0).active = true
            progressView.trailingAnchor.constraintEqualToAnchor(toolbar.trailingAnchor, constant: -60.0).active = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addWebViewAsSubview() {
        webView = WKWebView()
        view.insertSubview(webView, atIndex: 0)

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        webView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        webView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        webView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    }

    func openPage(index: Int) {
        guard webView != nil else { return }

        title = "Loading..."
        let url = NSURL(string: "https://" + websites[index])!
        webView.loadRequest(NSURLRequest(URL: url))
    }

    //
    // MARK: - KVO
    func registerKVO() {
        // KVO observer 등록
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }
    func removeKVO() {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    //
    // MARK: - WKNavigationDelegate
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title = webView.title
    }

    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL

        if let host = url!.host {
            for website in websites {
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
        
        decisionHandler(.Cancel)
    }


    //
    // MARK:- IB actions
    @IBAction func openPressed(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .ActionSheet)

        //
        // UIAlertAction은 style에 따라서 그룹핑이 된다.
        //
        for i in 0...1 {
            ac.addAction(UIAlertAction(title: websites[i], style: .Default) { (action:UIAlertAction) -> Void in
                self.openPage(i)
                })
        }

        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))

        presentViewController(ac, animated: true, completion: nil)
    }

    @IBAction func refreshPressed(sender: UIBarButtonItem) {
        logTrace()
        webView.reload()
    }
}

