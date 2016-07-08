//
//  MengDay+CoreDataProperties.swift
//  MengDay
//
//  Created by Steven Xu on 2016-07-08.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MengDay {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var birthday: NSDate?

}
