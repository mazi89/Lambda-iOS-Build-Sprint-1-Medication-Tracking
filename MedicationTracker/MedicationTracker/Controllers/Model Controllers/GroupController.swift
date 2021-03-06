//
//  GroupController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class GroupController: Codable {
    
    static var groupController = GroupController()
    var groups: [Group] = []
    
    func create(name: String, items: [Item]) -> Group {
        let newGroup = Group(name: name, items: items)
        self.groups.append(newGroup)
        
        //For the sake of sending the group from the controller as opposed to this temporary instance I'm doing this in a little bit of a convoluted way.
            guard let indexOfNewGroup = self.groups.firstIndex(of: newGroup) else { fatalError() }
        
        return self.groups[indexOfNewGroup]
    }
    
    func delete(group: Group) {
        guard let groupToBeDeleted = groups.firstIndex(of: group) else { fatalError() }
        groups.remove(at: groupToBeDeleted)
    }
    
    func newAlerts(identifier: Identifier) {
    }
    
    
    func muteAlerts() {
        
    }
    
    func deleteItem(for group: Group, at item: Item) {
        guard let thisGroup = groups.first(where:  { $0 == group } ) else { return }
        thisGroup.items.removeAll(where: ( {$0 == item} ) )
        
    }
    
    // MARK: - Data Permanence Functionality
    var groupURL: URL? {
    get {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let plistFile = documentsDir.appendingPathComponent("GroupsTrackers.plist")
        
        return plistFile
        
        }
    }
    
    func saveToPersistentStore() {
        
        guard let plistURL = groupURL else { return }
        let propertyList = PropertyListEncoder()
        
        do {
            let groupsData = try propertyList.encode(groups)
            try groupsData.write(to: plistURL)
        } catch {
            print("Error Groups Items: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let plistURL = groupURL else { return }
            let groupData = try Data(contentsOf: plistURL)
            let plistDecoder = PropertyListDecoder()
            let decodedGroups = try plistDecoder.decode([Group].self , from: groupData)
            groups = decodedGroups
            
        } catch {
            print("Failed to load decoded Groups array: \(error)")
        }
    }
}
