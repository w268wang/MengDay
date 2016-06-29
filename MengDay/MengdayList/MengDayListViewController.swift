//
//  MengDayListViewController.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit
import ContactsUI

class MengDayListViewController: UITableViewController {
    
    var dataProvider: MengDayListDataProvider?
    
    override func viewDidLoad() {
        
        tableView.dataSource = dataProvider
        dataProvider?.registerCellsForTableView(tableView)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPerson")
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider?.today = NSDate()
    }
    
    func addPerson() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
}

extension MengDayListViewController: CNContactPickerDelegate {
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        print("name: \(contact.givenName) \(contact.familyName), birthday: \(contact.birthday)")
        
        if let birthday = contact.birthday {
            let person = MengDay(firstName: contact.givenName, lastName: contact.familyName, birthday: birthday)
            print(person)
            dataProvider?.addBirthday(person)
            tableView.reloadData()
        }
    }
}