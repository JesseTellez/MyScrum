//
//  Board.swift
//  MyScrum
//
//  Created by Jesse Tellez on 4/25/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//

import Foundation
import CoreData


class Board: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
    }

    func updateTotalPercentage() {
        
        var newPercentage: Int32!
        
        if let currentInt = self.currentPoints?.intValue, intTotal = self.totalPoints?.intValue {
            newPercentage = currentInt/intTotal
            
            self.progress = NSNumber(int: newPercentage)
        }
        self.progress = 0
    }
    
}
