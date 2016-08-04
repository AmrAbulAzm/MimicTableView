//
//  PlayerMimicTableViewCell.swift
//  CustomTableView
//
//  Created by Amr Abulazm on 02/08/16.
//  Copyright © 2016 Amr AbulAzm. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerMimicTableViewCell: MimicTableViewCell {
    
    var playButton = UIButton(frame: CGRectMake(0,0,50,50))
    var soundPlayer: AVAudioPlayer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(playButton)
        self.backgroundColor = UIColor.blueColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.text = "Player Cell"
        playButton.setTitle("Play", forState: UIControlState.Normal)
        playButton.addTarget(self, action: #selector(PlayerMimicTableViewCell.playSound), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func playSound() {
        let path = NSBundle.mainBundle().pathForResource("brsman", ofType:"mp3")!
        let url = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            soundPlayer = sound
            sound.play()
        } catch {
            print("AVAudioPlayer failed")
        }
    }
    
}