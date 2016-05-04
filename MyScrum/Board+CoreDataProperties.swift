//
//  Board+CoreDataProperties.swift
//  MyScrum
//
//  Created by Jesse Tellez on 4/25/16.
//  Copyright © 2016 Inspiright. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Board {

    @NSManaged var title: String?
    @NSManaged var totalPoints: NSNumber?
    @NSManaged var subject: String?
    @NSManaged var tasks: NSSet?
    @NSManaged var reminders: NSSet?
    @NSManaged var goals: NSSet?

}
