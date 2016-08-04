//
//  MimicTableView.swift
//  CustomTableView
//
//  Created by Amr Abulazm on 01/08/16.
//  Copyright © 2016 Amr AbulAzm. All rights reserved.
//

import Foundation
import UIKit

private var MimicTableViewAssociationKey: UInt8 = 0

protocol MimicTableViewDataSource: NSObjectProtocol {
    func numberOfItemsInMimicTableView(mimicTableView: MimicTableView) -> Int
    func mimicTableView(mimicTableView: MimicTableView, cellForItemAtIndex index: Int) -> MimicTableViewCell
}

protocol MimicTableViewDelegate: NSObjectProtocol {
    func mimicTableView(mimicTableView: MimicTableView, didSelectItemAtIndex index: Int)
}

class MimicTableView: UIScrollView {
    
    var contentView = UIView()
    var renderedRange = NSMakeRange(0, 0)
    var reusableCells = Set<MimicTableViewCell>()
    
    weak var dataSource: MimicTableViewDataSource?
    weak var mimicDelegate: MimicTableViewDelegate?
    
    var itemSize: CGSize? {
        didSet {
            guard let _itemSize = itemSize else {
                return
            }
            if !CGSizeEqualToSize(oldValue ?? CGSizeZero, _itemSize) {
                if let totalItems = dataSource?.numberOfItemsInMimicTableView(self) {
                    var contentFrame: CGRect = contentView.frame
                    contentFrame.size.height = CGFloat(totalItems) * _itemSize.height
                    contentFrame.size.width = CGRectGetWidth(self.bounds)
                    contentView.frame = contentFrame
                    self.contentSize = contentFrame.size
                }
            }
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.addSubview(contentView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MimicTableView.didTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func computeVisibleRange() -> NSRange {
        guard let _itemSize = itemSize else {
            return NSMakeRange(0, 0) //TODO: handle error
        }
        
        let bounds: CGRect = self.bounds
        let location: Int = max(Int(0), Int(bounds.origin.y / _itemSize.height))
        var length: Int = Int(max(Float(0), ceilf((Float(bounds.size.height) + fmodf(Float(bounds.origin.y), Float(_itemSize.height))) / Float(_itemSize.height))))
        
        guard let totalItems = dataSource?.numberOfItemsInMimicTableView(self) else {
            return NSMakeRange(0, 0) //TODO: handle error
        }
        
        if (location + length) > totalItems {
            length = max(0, totalItems - location)
        }
        
        return NSMakeRange(location, length)
    }

    func dequeueReusableCell() -> MimicTableViewCell? {
        guard let cell: MimicTableViewCell = reusableCells.first else {
            return nil //TODO: handle error
        }
        
        reusableCells.removeFirst()
        return cell
    }
    
    func recycleCellAtIndex(index: Int) {
        for cell: UIView in contentView.subviews {
            guard
                let num: Int = objc_getAssociatedObject(self, &MimicTableViewAssociationKey) as? Int,
                let mimicCell = cell as? MimicTableViewCell else {
                return //TODO: handle error
            }
            if index == num {
                reusableCells.insert(mimicCell)
                cell.removeFromSuperview()
            }
        }
    }
    
    func renderCellAtIndex(index: Int) {
        guard
            let cell: MimicTableViewCell = dataSource?.mimicTableView(self, cellForItemAtIndex: index),
            let _itemSize = itemSize else {
            return //TODO: handle error
        }
        
        objc_setAssociatedObject(self, &MimicTableViewAssociationKey, cell, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        var rect: CGRect = CGRectZero
        rect.size = _itemSize
        rect.origin = CGPointMake(0, CGFloat(index) * _itemSize.height)
        cell.frame = rect
        contentView.addSubview(cell)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let visibleRange: NSRange = self.computeVisibleRange()
        if !NSEqualRanges(visibleRange, renderedRange) {
            for i in renderedRange.location..<NSMaxRange(renderedRange) {
                if !NSLocationInRange(i, visibleRange) {
                    self.recycleCellAtIndex(i)
                }
            }
            
            for i in visibleRange.location..<NSMaxRange(visibleRange) {
                if !NSLocationInRange(i, renderedRange) {
                    self.renderCellAtIndex(i)
                }
            }
            
            renderedRange = visibleRange;
        }
    }
    
    func didTap(sender:UITapGestureRecognizer) {
        mimicDelegate?.mimicTableView(self, didSelectItemAtIndex: 0) //TODO: Implement to figure out which cell has been tapped
    }
}



