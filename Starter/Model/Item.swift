//
//  Item.swift
//  Starter
//
//  Created by Xumak on 23/09/20.
//

import Foundation
import CoreData

final public class Item: NSManagedObject, Identifiable {
    @NSManaged var createdAt: Date?
    @NSManaged var title: String?
}

extension Item {
    static func getAllItems() -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest() as! NSFetchRequest<Item>
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
