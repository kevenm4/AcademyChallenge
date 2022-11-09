//
//  EmojiCoreData.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 11/10/2022.
//

import CoreData
import UIKit

class EmojiCoreData {

    var emojiPersistence: [NSManagedObject] = []

    let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func persist(name: String, imageUrl: String) {
        DispatchQueue.main.async {
            let managedContext = self.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "EmojiEntity", in: managedContext)!

            let emoji = NSManagedObject(entity: entity, insertInto: managedContext)

            emoji.setValue(name, forKeyPath: "name")

            emoji.setValue(imageUrl, forKey: "imageUrl")

            do {

                try managedContext.save()

                self.emojiPersistence.append(emoji)

            } catch let error as NSError {

                print("Could not save. \(error), \(error.userInfo)")
            }

        }
    }

    func fetch() -> [Emoji] {
        var array: [NSManagedObject] = []
        var result: [Emoji] = []
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")
        do {

            array = try managedContext.fetch(fetchRequest)
            result = array.compactMap({ item in
                item.toEmoji()
            })
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return result
    }

    func delete(emojiObject: Emoji) {

        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

        fetchRequest.predicate = NSPredicate(format: "name = %@", emojiObject.name as CVarArg)

        do {
            let emojiToDelete = try managedContext.fetch(fetchRequest)
            if emojiToDelete.count == 1 {
                guard let emoji = emojiToDelete.first else { return }
                managedContext.delete(emoji)
                try managedContext.save()
            }

        } catch let error as NSError {
            print("[DELETE EMOJI] Error to delete emoji: \(error)")
        }

    }

}
