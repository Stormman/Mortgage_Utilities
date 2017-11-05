//
//  ViewController.swift
//  Mortagage_Utilities
//
//  Created by Antonio Muñoz on 23/10/17.
//  Copyright © 2017 Antonio Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let re = Result.succes(89)
        
        let nuevo = re.map{$0 + 8  }
        
        
        
        let op  = 90000
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

