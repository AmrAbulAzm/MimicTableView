//
//  MapMimicTableViewCell.swift
//  CustomTableView
//
//  Created by Amr Abulazm on 02/08/16.
//  Copyright © 2016 Amr AbulAzm. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class MapMimicTableViewCell: MimicTableViewCell {
    
    var mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        //self.addSubview(mapView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = "Map Cell"
        mapView.frame = CGRectMake(0, 0, 200, 100)
        mapView.mapType = MKMapType.Standard
    }
    
}
