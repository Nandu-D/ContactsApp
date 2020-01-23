//
//  Contact.swift
//  ContactsApp
//
//  Created by Nandu Dharmapalan on 2019-12-15.
//  Copyright © 2019 Nandu Dharmapalan. All rights reserved.
//

import Foundation

class Contact : NSObject {
    var firstName: String
    var lastName: String
    var phoneNo: String
    var email: String
    var streetAddress1: String
    var streetAddress2: String
    var zipCode: String
    var favourite: Bool! = false
    var selected: Bool! = false
    
    init(firstName: String, lastName: String, phoneNo: String,
                  email: String, streetAddress1: String, streetAddress2: String,
                  zipCode: String, favourite: Bool, selected: Bool ) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNo = phoneNo
        self.email = email
        self.streetAddress1 = streetAddress1
        self.streetAddress2 = streetAddress2
        self.zipCode = zipCode
        self.favourite = favourite
        self.selected = selected
    }
}
