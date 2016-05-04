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
    
    func formatprogress(currentPoints: Int, maxPoints: Int) -> Int {
        
        if currentPoints != 0 {
            self.totalPoints = currentPoints / maxPoints
            return self.totalPoints as! Int
            
        } else {
            self.totalPoints = 0
            return self.totalPoints as! Int
        }
    }
    
    func updateTotalPoints(index: NSIndexPath) {
        
        
        if let tasks = self.tasks {
            for task in tasks {
                
            }
        }
        
    }

}
