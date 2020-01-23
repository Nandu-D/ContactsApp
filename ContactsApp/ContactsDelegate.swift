//
//  ContactsDelegate.swift
//  ContactsApp
//
//  Created by Nandu Dharmapalan on 2019-12-15.
//  Copyright © 2019 Nandu Dharmapalan. All rights reserved.
//

import Foundation

protocol ContactsDelegate {
    func addContact(contact: Contact)
    func editContact(position: Int, contact: Contact)
    func deleteContact(position: Int, contact: Contact)
}
