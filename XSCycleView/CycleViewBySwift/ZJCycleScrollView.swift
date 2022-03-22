//
//  XSCycleScrollView.swift
//  CycleViewBySwift
//
//  Created by zjwang on 16/4/12.
//  Copyright © 2016年 夏天. All rights reserved.
//

import UIKit
import Haneke

let sectionNum: Int = 100
let cellIdentifier: String = "cellIdentifier"
let width = (UIScreen.mainScreen().bounds.size.width)
let height = (UIScreen.mainScreen().bounds.size.width)
// 协议
protocol ZJCycleViewDelegate {
    func didSelectIndexCollectionViewCell(index: Int)->Void


    ///// bbbbbb
}

class ZJCycleScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var delegate: ZJCycleViewDelegate?
    var cycleCollectionView: UICollectionView?
    var images = NSMutableArray()
    var pageControl = UIPageControl()
    var flowlayout = UICollectionViewFlowLayout()
    var timer = NSTimer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews(frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 创建collectionview
    func createSubviews(frame: CGRect){
        cycleCollectionView = UICollectionView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), collectionViewLayout: flowlayout)
        flowlayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = 0;
        flowlayout.scrollDirection = UICollectionViewScrollDirection.Horizontal;

        cycleCollectionView!.backgroundColor = UIColor.lightGrayColor()
        cycleCollectionView!.pagingEnabled = true
        cycleCollectionView!.dataSource  = self
        cycleCollectionView!.delegate = self
        cycleCollectionView!.showsHorizontalScrollIndicator = false
        cycleCollectionView!.showsVerticalScrollIndicator = false
        cycleCollectionView!.registerClass(ZJCustomCycleCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.addSubview(cycleCollectionView!)
        
        pageControl = UIPageControl.init(frame: CGRectMake(0, 0, frame.size.width / 2, 30))
        pageControl.center = CGPointMake(frame.size.width / 2, frame.size.height - 20);
        self.addSubview(pageControl);
        self.addTimer()
        
    }
    func addTimer(){
        let timer1 = NSTimer.init(timeInterval: 2, target: self, selector: "nextPageView", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer1, forMode: NSRunLoopCommonModes)
        timer = timer1
    }
    func removeTimer(){
        self.timer.invalidate()
    }
    func returnIndexPath()->NSIndexPath{
        var currentIndexPath = cycleCollectionView!.indexPathsForVisibleItems().last
        currentIndexPath = NSIndexPath.init(forRow: (currentIndexPath?.row)!, inSection: sectionNum / 2)
        cycleCollectionView!.scrollToItemAtIndexPath(currentIndexPath!, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
        return currentIndexPath!;
    }
    func nextPageView(){

        let indexPath = self.returnIndexPath()
        var item = indexPath.row + 1;
        var section = indexPath.section;
        if item == images.count {
            item = 0
            section++
        }
        self.pageControl.currentPage = item;
        let nextIndexPath = NSIndexPath.init(forRow: item, inSection: section)
        cycleCollectionView!.scrollToItemAtIndexPath(nextIndexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    // Delegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ZJCustomCycleCell
        cell.labelTitle.text = NSString(format: "%d", indexPath.row) as String
        let url:String = self.images[indexPath.row] as! String
        cell.imageView.hnk_setImageFromURL(NSURL.init(string: url)!)
        return cell
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionNum
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = images.count
        return images.count
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer()
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer()
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = (Int(scrollView.contentOffset.x) / Int(width)) % images.count
        pageControl.currentPage = page
    }
    // 点击 
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        self.delegate?.didSelectIndexCollectionViewCell(indexPath.row)
    }
}
