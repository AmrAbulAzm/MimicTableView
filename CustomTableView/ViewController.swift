//
//  ViewController.swift
//  CustomTableView
//
//  Created by Amr Abulazm on 01/08/16.
//  Copyright © 2016 Amr AbulAzm. All rights reserved.
//

import UIKit

enum CellItem {
    case MapCell
    case ImageCell
    case PlayerCell
    
    var cellIdentifier: String {
        switch self {
        case .MapCell: return "MapCellIdentifier"
        case .ImageCell: return "ImageCellIdentifier"
        case .PlayerCell: return "PlayerCellIdentifier"
        }
    }
}

class ViewController: UIViewController {
    
    let itemHeight: CGFloat = 100.0
    
    var tableView: MimicTableView!
    var cellItems: [CellItem] = [.ImageCell, .MapCell, .PlayerCell, .PlayerCell, .MapCell, .MapCell, .PlayerCell, .ImageCell, .MapCell]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = MimicTableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        tableView.dataSource = self
        tableView.mimicDelegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.itemSize = CGSize(width: self.tableView.frame.size.width, height: itemHeight)
        tableView.backgroundColor = UIColor.redColor()
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: MimicTableViewDataSource {
    func numberOfItemsInMimicTableView(mimicTableView: MimicTableView) -> Int {
        return cellItems.count
    }
    
    func mimicTableView(mimicTableView: MimicTableView, cellForItemAtIndex index: Int) -> MimicTableViewCell {
        let item = cellItems[index]
        var cell = mimicTableView.dequeueReusableCell()
        if cell == nil {
            switch item.cellIdentifier {
            case "MapCellIdentifier":
                cell = MapMimicTableViewCell(frame: CGRectMake(0,0,self.view.frame.size.width, itemHeight))
            case "PlayerCellIdentifier":
                cell = PlayerMimicTableViewCell(frame: CGRectMake(0,0,self.view.frame.size.width, itemHeight))
            case "ImageCellIdentifier":
                cell = ImageMimicTableViewCell(frame: CGRectMake(0,0,self.view.frame.size.width, itemHeight))
            default:
                cell = MimicTableViewCell(frame: CGRectMake(0,0,self.view.frame.size.width, itemHeight))
            }
        }
        
        switch item.cellIdentifier {
        
        case "MapCellIdentifier": break
            //
        case "PlayerCellIdentifier": break
            //
        case "ImageCellIdentifier": break
            //
        default: break
        }
        
        return cell!
    }
}

extension ViewController: MimicTableViewDelegate {
    func mimicTableView(mimicTableView: MimicTableView, didSelectItemAtIndex index: Int) {
        // do whatever you want
    }
}

