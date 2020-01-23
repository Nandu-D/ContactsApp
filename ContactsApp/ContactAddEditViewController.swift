//
//  ContactAddEditViewController.swift
//  ContactsApp
//
//  Created by Nandu Dharmapalan on 2019-12-15.
//  Copyright © 2019 Nandu Dharmapalan. All rights reserved.
//

import UIKit

@objcMembers class ContactAddEditViewController: UIViewController {

    var delegate: ContactsDelegate!
    var position: Int = -1
    var contact: Contact = Contact(firstName: "", lastName: "", phoneNo: "", email: "", streetAddress1: "", streetAddress2: "", zipCode: "", favourite: false, selected: false)
    var isNewContact: Bool = true
    var isContactEmpty: Bool = true
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var streetAddress1TF: UITextField!
    @IBOutlet weak var streetAddress2TF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!
    @IBOutlet weak var favouriteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isNewContact {
            firstNameTF.text = contact.firstName
            lastNameTF.text = contact.lastName
            phoneNumberTF.text = contact.phoneNo
            emailTF.text = contact.email
            streetAddress1TF.text = contact.streetAddress1
            streetAddress2TF.text = contact.streetAddress2
            zipCodeTF.text = contact.zipCode
            favouriteSwitch.setOn(contact.favourite, animated: true)
        }
    }
    
    func doneTapped() {
        if let firstNameValue: String = firstNameTF.text {
            contact.firstName = firstNameValue
        }
        if let lastNameValue = lastNameTF.text {
            contact.lastName = lastNameValue
        }
        if let phoneNumberValue = phoneNumberTF.text {
                contact.phoneNo = phoneNumberValue
        }
        if let emailValue = emailTF.text {
                contact.email = emailValue
        }
        if let streetAddress1Value = streetAddress1TF.text {
                contact.streetAddress1 = streetAddress1Value
        }
        if let streetAddress2Value = streetAddress2TF.text {
                contact.streetAddress2 = streetAddress2Value
        }
        if let zipCodeValue = zipCodeTF.text {
                contact.zipCode = zipCodeValue
        }
        if favouriteSwitch.isOn {
            contact.favourite = true
        } else {
            contact.favourite = false
        }
        
        if contact.firstName != "" || contact.lastName != "" || contact.email != "" ||
            contact.phoneNo != "" || contact.streetAddress1 != "" ||
            contact.streetAddress2 != "" || contact.zipCode != "" {
            isContactEmpty = false
        }
        
        if isNewContact {
            if !isContactEmpty {
                delegate.addContact(contact: contact)
            }
        } else {
            if (!isContactEmpty) {
                delegate.editContact(position: position, contact: contact)
            } else {
                
            }
        }
    navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
