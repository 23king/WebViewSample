//
//  ViewController.swift
//  WebViewSample
//
//  Created by shinobu okano on 2015/08/05.
//  Copyright (c) 2015年 shinobu okano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    var topURL = "https://www.google.com/"
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var forward: UIBarButtonItem!
    @IBOutlet weak var back: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        updateView()

        let width: CGFloat! = self.view.bounds.width
        let height: CGFloat! = self.view.bounds.height
        let statusBarHeight: CGFloat! = UIApplication.sharedApplication().statusBarFrame.height
        webView.frame = CGRectMake(0, statusBarHeight, width, height - statusBarHeight)
        
        var url = NSURL(string: topURL)
        var request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        NSLog(webView.stringByEvaluatingJavaScriptFromString("document.title")!)
        updateView()
    }
    
    @IBAction func openSafari(sender: AnyObject) {
        let url = webView.request?.URL
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func forward(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func back(sender: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func reload(sender: AnyObject) {
        let urlString = webView.stringByEvaluatingJavaScriptFromString("document.URL")! as String
        let url = NSURL(string: urlString)
        webView.loadRequest(NSURLRequest(URL: url!))
    }
    
    func updateView() {
        forward.enabled = webView.canGoForward
        back.enabled = webView.canGoBack
    }
}

