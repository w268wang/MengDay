//
//  MengDayListDataProvider.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit

class MengDayListDataProvider: NSObject, UITableViewDataSource {
    
    private let cellIdentifer = "Cell"
    private var birthdays = [MengDay]()
    
    private let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    
    var todayComponents: NSDateComponents?
    var today: NSDate? {
        didSet {
            if let today = today {
                todayComponents = gregorian?.components([.Month, .Day, .Year], fromDate: today)
            }
        }
    }
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.registerClass(MengDayCell.self, forCellReuseIdentifier: cellIdentifer)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as! MengDayCell
        
        let birthday = birthdays[indexPath.row]
        cell.nameLabel.text = birthday.firstName
        cell.patternNameLabel.text = birthday.firstName
        cell.birthdayLabel.text = "\(birthday.birthday.day) \(birthday.birthday.month)"
        
        if let progress = progressUntilBirthday(birthday) {
            cell.updateProgress(progress)
        }
        
        return cell
    }
    
    func progressUntilBirthday(birthday: MengDay) -> Float? {
        let calculationComponents = birthday.birthday
        
        if let today = today, todayComponents = todayComponents, date = birthday.birthday.date {
            if gregorian!.compareDate(today, toDate: date, toUnitGranularity: [.Month, .Day]) == .OrderedDescending {
                calculationComponents.year = todayComponents.year + 1
            } else {
                calculationComponents.year = todayComponents.year + 1
            }
            
            let components = gregorian?.components([.Day], fromDateComponents: todayComponents, toDateComponents: calculationComponents, options: [])
            
            return 1.0-Float(components!.day)/Float(365)
        } else {
            return nil
        }
    }
}

extension MengDayListDataProvider {
    func addBirthday(birthday: MengDay) {
        birthdays.append(birthday)
        birthdays.sortInPlace { progressUntilBirthday($0) > progressUntilBirthday($1) }
    }
}