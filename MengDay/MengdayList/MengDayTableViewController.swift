//
//  MengDayListViewController.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit
import ContactsUI
import CoreData

class MengDayTableViewController: UITableViewController {
    
    var dataProvider: MengDayListDataProvider!
    let picker = CNContactPickerViewController()
    var document: UIManagedDocument {
        return dataProvider.document
    }
    
    override func viewDidLoad() {
        // potential memory leak?
        dataProvider = MengDayListDataProvider { self.tableView.reloadData() }
        tableView.dataSource = dataProvider
        picker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider.today = NSDate()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(contextChanged), name: NSManagedObjectContextDidSaveNotification, object: document.managedObjectContext)
    }

    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSManagedObjectContextDidSaveNotification, object: document.managedObjectContext)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func addPerson(sender: UIBarButtonItem) {
        navigationController?.presentViewController(picker, animated: true, completion: nil)
    }

    func contextChanged(notification: NSNotification) {
        NSLog("Context changed: \(notification.userInfo)")

    }

}

extension MengDayTableViewController: CNContactPickerDelegate {
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        if let birthday = contact.birthday?.date {
            dataProvider.addBirthday(contact.givenName, lastName: contact.familyName, birthday: birthday)
            tableView.reloadData()
        }
    }
}
