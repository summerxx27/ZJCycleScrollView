//
//  ViewController.swift
//  XSCycleView
//
//  Created by zjwang on 16/4/13.
//  Copyright © 2016年 夏天. All rights reserved.
//

import UIKit
class ViewController: UIViewController, ZJCycleViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cycle = ZJCycleScrollView.init(frame: CGRectMake(0, 70, width, 175))
        cycle.delegate = self;
        let images: NSMutableArray = ["http://images11.app.happyjuzi.com/news/201604/12/570c656b35ae9.jpg", "http://images11.app.happyjuzi.com/news/201604/12/570c8bc8e0b33.jpg", "http://images11.app.happyjuzi.com/news/201604/12/570c656b35ae9.jpg", "http://images11.app.happyjuzi.com/news/201604/12/570c8bc8e0b33.jpg"]
        cycle.images = images
        
        self.view.addSubview(cycle)
        
    }
    func didSelectIndexCollectionViewCell(index: Int) {
        print("\(index)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

