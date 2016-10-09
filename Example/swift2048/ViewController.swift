//
//  ViewController.swift
//  Example
//
//  Created by Kohei Iwasaki on 9/13/16.
//  Copyright © 2016 Antelos. All rights reserved.
//

import UIKit
import Swift2048Game

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Game.sharedInstance.addObserver(self, forKeyPath: "turn", options: NSKeyValueObservingOptions(), context: nil)
        Game.sharedInstance.nextTurn()
    }
    
    // When the turn of the Game changed, this method is called
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print(Game.sharedInstance.board)
    }
    
    deinit {
        Game.sharedInstance.removeObserver(self, forKeyPath: "turn")
    }

}

