//
//  MengDayListDataProvider.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit
import CoreData

class MengDayListDataProvider: NSObject, UITableViewDataSource {
    
    private let cellIdentifer = "Cell"
    private var birthdays = [MengDay]()
    var document: UIManagedDocument!

    override private init() {
        super.init()
    }

    convenience init(restorationCallback: () -> ()) {
        self.init()
        setupDocument(restorationCallback)
    }

    private let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    
    var todayComponents: NSDateComponents?
    var today: NSDate? {
        didSet {
            if let today = today {
                todayComponents = today.convertToComponents()
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as! MengDayCell
        
        let birthday = birthdays[indexPath.row]
        cell.nameLabel.text = birthday.firstName
        cell.patternNameLabel.text = birthday.firstName
        if let birthdayComp = birthday.birthday?.convertToComponents() {
            cell.birthdayLabel.text = "\(birthdayComp.day) \(birthdayComp.month)"
        }

        if let progress = progressUntilBirthday(birthday) {
            cell.updateProgress(progress)
        }
        
        return cell
    }
    
    func progressUntilBirthday(birthday: MengDay) -> Float? {
        
        let calculationComponents = (birthday.birthday!.copy() as! NSDate).convertToComponents()
        if let todayComponents = todayComponents {
            calculationComponents.year = todayComponents.year
            
            if calculationComponents.month < todayComponents.month ||
                (calculationComponents.month == todayComponents.month &&
                    calculationComponents.day < todayComponents.day) {
                
                calculationComponents.year += 1 // Swift 3 compliant ...
            }
            
            let components = gregorian?.components([.Day],
                                                   fromDateComponents: todayComponents,
                                                   toDateComponents: calculationComponents,
                                                   options: [])
            
            return 1.0-Float(components!.day)/Float(365)
        } else {
            return nil
        }
    }

    func setupDocument(restorationCallback: () -> ()) {
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentName = "BirthdayHistory"
        let url = documentsDirectory.first!.URLByAppendingPathComponent(documentName)
        document = UIManagedDocument(fileURL: url)
        if NSFileManager.defaultManager().fileExistsAtPath(url.path!) {
            document.openWithCompletionHandler { success in
                if success {
                    self.restoreBirthdays(restorationCallback)
                } else  {
                    NSLog("Cannot open document at url: \(url)")
                }
            }
        } else {
            document.saveToURL(url, forSaveOperation: .ForCreating) { success in
                if !success {
                    NSLog("Cannot create document at url: \(url)")
                }
            }
        }
    }

    func addBirthday(firstName: String, lastName: String, birthday: NSDate) {
        if document.documentState == .Normal {
            let mBirthday = NSEntityDescription.insertNewObjectForEntityForName("MengDay", inManagedObjectContext: document.managedObjectContext) as! MengDay
            mBirthday.firstName = firstName
            mBirthday.lastName = lastName
            mBirthday.birthday = birthday
            birthdays.append(mBirthday)
            birthdays.sortInPlace(compareBirthday)
        }
    }

    func restoreBirthdays(callback: () -> ()) {
        let request = NSFetchRequest(entityName: "MengDay")
        if document.documentState == .Normal {
            if let rawBirthdays = try? document.managedObjectContext.executeFetchRequest(request) as! [MengDay] {
                for birthday in rawBirthdays {
                    NSLog("Restoring: \(birthday.firstName) \(birthday.lastName)")
                    birthdays.append(birthday)
                }
                birthdays.sortInPlace(compareBirthday)
                callback()
            }

        }
    }

    func compareBirthday(md1: MengDay, md2: MengDay) -> Bool {
        return progressUntilBirthday(md1) > progressUntilBirthday(md2)
    }

}

extension NSDate {
    func convertToComponents() -> NSDateComponents {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        return gregorian.components([.Month, .Day, .Year], fromDate: self)
    }
}

