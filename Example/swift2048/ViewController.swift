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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(Game.sharedInstance.board)
    }
    
    deinit {
        Game.sharedInstance.removeObserver(self, forKeyPath: "turn")
    }

}

