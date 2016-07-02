//
//  MengDay.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import Foundation

struct MengDay: Equatable {
    let firstName: String
    let lastName: String
    let birthday: NSDateComponents
}

func ==(lhs: MengDay, rhs: MengDay) -> Bool {
    return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.birthday == rhs.birthday
}