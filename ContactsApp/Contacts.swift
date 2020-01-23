//
//  Contacts.swift
//  ContactsApp
//
//  Created by Nandu Dharmapalan on 2019-12-15.
//  Copyright © 2019 Nandu Dharmapalan. All rights reserved.
//

import Foundation

class Contacts {
    var contacts:[Contact] = []
    var filteredContacts:[Contact] = []
    
    init() {
        
    }
    
    func deleteContact(position: Int, isInFavouriteList: Bool) {
        if (isInFavouriteList) {
            let contact = filteredContacts[position]
            for (index, item) in contacts.enumerated() {
                if item.firstName == contact.firstName && item.lastName == contact.lastName && item.email == contact.email && item.phoneNo == contact.email && item.streetAddress1 == contact.streetAddress1 && item.streetAddress2 == contact.streetAddress2 && item.favourite == contact.favourite {
                    contacts.remove(at: index)
                    break
                }
                filteredContacts.remove(at: position)
            }
        } else {
            contacts.remove(at: position)
            sortContacts()
        }
    }
    
    func sortContacts() {
        contacts = contacts.sorted(by: {$0.firstName + $0.lastName < $1.firstName + $0.lastName})
        filteredContacts = filteredContacts.sorted(by: {$0.firstName + $0.lastName < $1.firstName + $0.lastName})
        filteredContacts = filteredContacts.sorted(by: {$0.firstName + $0.lastName < $1.firstName + $0.lastName})
    }
    
    func addContact(contact: Contact) {
        contacts.append(contact)
        if contact.favourite {
            filteredContacts.append(contact)
        }
        sortContacts()
    }
    
    func rearrangeContacts(from: Int, to: Int, isInFavouriteList: Bool) {
        if isInFavouriteList {
            let contact = filteredContacts[from]
            
            filteredContacts.remove(at: from)
            filteredContacts.insert(contact, at: to)
        } else {
            let contact = contacts[from]
            contacts.remove(at: from)
            contacts.insert(contact, at: to)
        }
    }
    
    func getFavourites() -> [Contact]{
        filteredContacts = contacts.filter {
            (contact: Contact) -> Bool in return contact.favourite
        }
        return filteredContacts
    }
}
