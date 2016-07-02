//
//  MengDayListViewController.swift
//  MengDay
//
//  Created by Weijie Wang on 2016-06-28.
//  Copyright © 2016 Weijie Wang. All rights reserved.
//

import UIKit
import ContactsUI

class MengDayTableViewController: UITableViewController {
    
    let dataProvider = MengDayListDataProvider()
    let picker = CNContactPickerViewController()
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        picker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataProvider.today = NSDate()
    }
    
    @IBAction func addPerson(sender: UIBarButtonItem) {
        navigationController?.presentViewController(picker, animated: true, completion: nil)
    }

}

extension MengDayTableViewController: CNContactPickerDelegate {
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        if let birthday = contact.birthday {
            let person = MengDay(firstName: contact.givenName, lastName: contact.familyName, birthday: birthday)
            dataProvider.addBirthday(person)
            tableView.reloadData()
        }
    }
}