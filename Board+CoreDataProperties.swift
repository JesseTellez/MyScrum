//
//  Board+CoreDataProperties.swift
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

extension Board {

    @NSManaged var subject: String?
    @NSManaged var title: String?
    @NSManaged var totalPoints: NSNumber?
    @NSManaged var currentPoints: NSNumber?
    @NSManaged var progress: NSNumber?
    @NSManaged var goals: NSSet?
    @NSManaged var reminders: NSSet?
    @NSManaged var tasks: NSSet?

}
