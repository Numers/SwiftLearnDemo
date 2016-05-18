//
//  ThirdViewController.swift
//  SwiftLearnDemo
//
//  Created by baolicheng on 15/12/8.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let request:NSURLRequest! = NSURLRequest.init(URL: NSURL.init(string: "http://www.baidu.com")!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
