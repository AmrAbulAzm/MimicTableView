//
//  MimicTableViewCell.swift
//  CustomTableView
//
//  Created by Amr Abulazm on 01/08/16.
//  Copyright © 2016 Amr AbulAzm. All rights reserved.
//

import UIKit
import MapKit

class MimicTableViewCell: UIView {
    
    var titleLabel = UILabel(frame: CGRectMake(220,0,100,50))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = "DefaultCell"
        self.addSubview(titleLabel)
    }
    
}
