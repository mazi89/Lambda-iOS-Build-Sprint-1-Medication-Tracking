//
//  GroupsForItemTableViewCell.swift
//  MedicationTracker
//
//  Created by ashley llaverias on 3/14/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class GroupsForItemTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var groupNameLabel: UILabel!
    
    // MARK: - Properties
    var group: Group? {
        didSet {
            updateViews()
        }
    }
    var item: Item?
    var updateTable: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        groupNameLabel.text = group?.name
    }
    
    // MARK: - Button Functionality

    @IBAction func delButtonTapped(_ sender: Any) {
        guard let item = item,
        let group = group,
        let reload = updateTable else { return }
        
        group.items.removeAll{ $0 == item }
        reload()
        GroupController.groupController.saveToPersistentStore()
    }
}
