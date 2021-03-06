

import Foundation
import UIKit

extension GuestListView {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if self.isSearching == true {
            return 1
        }
        return self.guestSectionTitles.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.isSearching == true {
            return nil
        }
        return guestSectionTitles[section]
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if self.isSearching == true {
            return nil
        }
        return guestSectionTitles
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearching == true {
            return self.filteredSearchResults!.count
        }
        let guestKey = guestSectionTitles[section]
        if let guestValues = guestsDictionary[guestKey] {
            return guestValues.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guestCell: GuestTableViewCell = tableView.dequeueReusableCell(withIdentifier: GuestTableViewCell.cellID, for: indexPath) as! GuestTableViewCell
        
        if self.isSearching == true {
            let searchResult = self.filteredSearchResults![indexPath.row]
            guestCell.guestNameLabel.text = searchResult.firstName
            guestCell.ticketTypeNameLabel.text = searchResult.priceInCents.dollarString + " | " + searchResult.ticketType
            
            if searchResult.status == "Purchased" {
                guestCell.ticketStateView.tagLabel.text = "PURCHASED"
                guestCell.ticketStateView.backgroundColor = UIColor.brandGreen
            } else {
                guestCell.ticketStateView.tagLabel.text = "REDEEMED"
                guestCell.ticketStateView.backgroundColor = UIColor.brandBlack
            }
            return guestCell
        }
        
        
        let guestKey = guestSectionTitles[indexPath.section]
        if let guestValues = guestsDictionary[guestKey] {
            guestCell.guestNameLabel.text = guestValues[indexPath.row].firstName
            guestCell.ticketTypeNameLabel.text = guestValues[indexPath.row].priceInCents.dollarString + " | " + guestValues[indexPath.row].ticketType
            
            if guestValues[indexPath.row].status == "Purchased" {
                guestCell.ticketStateView.tagLabel.text = "PURCHASED"
                guestCell.ticketStateView.backgroundColor = UIColor.brandGreen
            } else {
                guestCell.ticketStateView.tagLabel.text = "REDEEMED"
                guestCell.ticketStateView.backgroundColor = UIColor.brandBlack
            }
        }
        return guestCell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Checkin") { (action, indexPath) in
            return
        }
        deleteButton.backgroundColor = UIColor.black
        return [deleteButton]
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
