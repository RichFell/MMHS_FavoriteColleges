//
//  WebViewController.swift
//  MMHS_FavoriteColleges
//
//  Created by Vik Denic on 8/5/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var college : CollegeObject!
    @IBOutlet weak var myWebView: UIWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        if college.urlString.hasPrefix("http://")
        {
            let webURL = NSURL(string: college.urlString)
            let urlRequest = NSURLRequest(URL: webURL)
            myWebView.loadRequest(urlRequest)
        }
        else
        {
            let prefixedString = "http://" + college.urlString
            let websiteURL = NSURL(string: prefixedString)
            let urlRequest = NSURLRequest(URL: websiteURL)
            myWebView.loadRequest(urlRequest)
        }
        myWebView.scalesPageToFit = true
    }

    @IBAction func onDismissButtonTapped(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onForwardTapped(sender: UIButton)
    {
        myWebView.goForward()
    }

    @IBAction func onBackTapped(sender: UIButton)
    {
        myWebView.goBack()
    }

    //Webview delegates
    func webViewDidStartLoad(webView: UIWebView!)
    {
        spinner.startAnimating()
    }

    func webViewDidFinishLoad(webView: UIWebView!)
    {
        spinner.stopAnimating()
    }
}
