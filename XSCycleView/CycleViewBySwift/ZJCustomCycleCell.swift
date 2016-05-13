//
//  XSCustomCycleCell.swift
//  CycleViewBySwift
//
//  Created by zjwang on 16/4/12.
//  Copyright © 2016年 夏天. All rights reserved.
//

import UIKit
class ZJCustomCycleCell: UICollectionViewCell {
    
    var urlImage: String = ""
    var imageView = UIImageView()
    var labelTitle = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews(frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews(frame: CGRect){
        imageView = UIImageView.init(frame: CGRectMake(25, 10, frame.size.width - 50, frame.size.height - 20))
        self.contentView.addSubview(imageView)
        
        labelTitle = UILabel.init(frame: CGRectMake(10, 10, 30, 30))
        imageView.addSubview(labelTitle)
    }
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        // do you something
        
    }
}
