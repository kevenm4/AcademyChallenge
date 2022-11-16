//
//  AvatarCoreData.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 12/10/2022.

import CoreData
import UIKit

class AvatarCoreData {

    var avatarPersistence: [NSManagedObject] = []

    let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func persist(currentAvatar: Avatar) {

        DispatchQueue.main.async {

            let managedContext = self.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "AvatarEntity", in: managedContext)!

            let avatar = NSManagedObject(entity: entity, insertInto: managedContext)

            avatar.setValue(currentAvatar.login, forKeyPath: "login")

            avatar.setValue(currentAvatar.avatarUrl.absoluteString, forKey: "avatarUrl")

            avatar.setValue(currentAvatar.id, forKey: "id")

            do {
                try managedContext.save()
            } catch let error as NSError {

                print("Could not save. \(error), \(error.userInfo)")
            }

        }
    }

    func fetch(_ resulthandler: @escaping ([Avatar]) -> Void) {

        var array: [NSManagedObject]
        var result: [Avatar] = []

        let managedContext =
        persistentContainer.viewContext
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        do {
            array = try managedContext.fetch(fetchRequest)
            result = array.compactMap({ item in
                item.toAvatar()
            })
            resulthandler(result)

        } catch let error as NSError {

            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }

    func checkIfItemExist(searchText: String, _ resultHandler: @escaping (Result<[NSManagedObject], Error>) -> Void) {

        let managedContext = self.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", searchText)

        do {
            let result = try managedContext.fetch(fetchRequest)
            resultHandler(.success(result))
        } catch {
            print(error)
            resultHandler(.failure(error))
        }

    }

    func delete(avatarObject: Avatar) {

        let managedContext = self.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

        fetchRequest.predicate = NSPredicate(format: "login = %@", avatarObject.login)

        do {
            let avatarToDelete = try managedContext.fetch(fetchRequest)
            if avatarToDelete.count == 1 {
                guard let avatar = avatarToDelete.first else { return }
                managedContext.delete(avatar)
                try managedContext.save()
            }

        } catch let error as NSError {
            print("[DELETE AVATAR] Error to delete avatar: \(error)")
        }

    }
}
