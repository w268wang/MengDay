//
//  MengDay.swift
//  MengDay
//
//  Created by Steven Xu on 2016-07-08.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import Foundation
import CoreData


class MengDay: NSManagedObject {

// Insert code here to add functionality to your managed object

}

func ==(lhs: MengDay, rhs: MengDay) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.birthday == rhs.birthday
}


