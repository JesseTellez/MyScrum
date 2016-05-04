//
//  Task+CoreDataProperties.swift
//  MyScrum
//
//  Created by Jesse Tellez on 5/1/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var created: NSDate?
    @NSManaged var details: String?
    @NSManaged var points: NSNumber?
    @NSManaged var status: String?
    @NSManaged var parentBoard: Board?

}
