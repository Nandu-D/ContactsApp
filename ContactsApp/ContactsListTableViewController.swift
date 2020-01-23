//
//  ContactsListTableViewController.swift
//  ContactsApp
//
//  Created by Nandu Dharmapalan on 2019-12-15.
//  Copyright © 2019 Nandu Dharmapalan. All rights reserved.
//

import UIKit

class ContactsListTableViewController: UITableViewController, ContactsDelegate {
    func addContact(contact: Contact) {
        contactsList.addContact(contact: contact)
        contactsList.sortContacts()
        if isBookmarkClicked {
            listToShow = contactsList.filteredContacts
        } else {
            listToShow = contactsList.contacts
        }
        tableView.reloadData()
    }
    
    func editContact(position: Int, contact: Contact) {
        contactsList.contacts[position] = contact
        contactsList.sortContacts()
        tableView.reloadData()
    }
    
    func deleteContact(position: Int, contact: Contact){
        if isBookmarkClicked {
            contactsList.deleteContact(position: position, isInFavouriteList: isBookmarkClicked)
        }
    }
    
    
    var contactsList: Contacts = Contacts()
    var listToShow: [Contact] = []
    var isBookmarkClicked: Bool = false
    var clickedPosition: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let bookmarkBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: Selector(("bookmarkClicked")))
        bookmarkBarButtonItem.style = UIBarButtonItem.Style.plain
        self.navigationItem.leftBarButtonItems = [self.editButtonItem, bookmarkBarButtonItem]
        
        isBookmarkClicked = false
        listToShow = contactsList.contacts
    }
    
    @objc func bookmarkClicked() {
        isBookmarkClicked = !isBookmarkClicked
        contactsList.sortContacts()
        if isBookmarkClicked {
            listToShow = contactsList.filteredContacts
            print(listToShow)
        } else {
            listToShow = contactsList.contacts
            print(listToShow)
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listToShow.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = "\(listToShow[indexPath.row].firstName) \(listToShow[indexPath.row].lastName)"

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contactsList.deleteContact(position: indexPath.row, isInFavouriteList: isBookmarkClicked)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        contactsList.rearrangeContacts(from: fromIndexPath.row, to: to.row, isInFavouriteList: isBookmarkClicked)
        if isBookmarkClicked {
            listToShow = contactsList.filteredContacts
        } else {
            listToShow = contactsList.contacts
        }
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellOnScreen :UIView = tableView.cellForRow(at: indexPath)!
        cellOnScreen.alpha = 0.1
        UIView.animate(withDuration: 1) {
            cellOnScreen.alpha = 1
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        clickedPosition = indexPath.row
        self.performSegue(withIdentifier: "goToAddOrEditContact", sender: self)
    }

    
    // MARK: - Navigation
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "goToAddOrEditContact" {
                if let addEditVC = segue.destination as? ContactAddEditViewController {
                    addEditVC.delegate = self
                    
                    if (clickedPosition != -1) {
                        if !(listToShow.count == 0) {
                            addEditVC.contact = listToShow[clickedPosition]
                            addEditVC.position = clickedPosition
                            addEditVC.isNewContact = false
                            addEditVC.isContactEmpty = false
                            addEditVC.title = "Edit"
                        }
                    } else {
                            addEditVC.isNewContact = true
                            addEditVC.title = "Add"
                    }
                }
                clickedPosition = -1
            }
        }
    }
    

}
