//
//  BoardDetailsVC.swift
//  MyScrum
//
//  Created by Jesse Tellez on 5/1/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//

import UIKit

class BoardDetailsVC: UIViewController {
    
    var selectedBoard: Board?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("My Item is \(selectedBoard)")
    }

}
