//
//  ImageMimicTableViewCell.swift
//  CustomTableView
//
//  Created by Amr Abulazm on 02/08/16.
//  Copyright © 2016 Amr AbulAzm. All rights reserved.
//

import UIKit

class ImageMimicTableViewCell: MimicTableViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = "Image Cell"
        imageView.frame = CGRectMake(0, 0, 200, 100)
        imageView.image = UIImage(named: "tick_64")
    }
    
}
