//
//  AvatarCoreData.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 12/10/2022.

import CoreData
import UIKit
//
import RxSwift
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

    func fetch() -> Single<[Avatar]> {

        return Single<[Avatar]>.create { single in

            let disposeble = Disposables.create { }

            let managedContext = self.persistentContainer.viewContext

            // FETCH ALL THE DATA FROM THE ENTITY PERSON
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

            guard
                let resultFetch = try? managedContext.fetch(fetchRequest)
            else {
                single(.failure(CoreDataError.fetchError))
                return disposeble
            }

            let result = resultFetch.compactMap({ item -> Avatar? in
                item.toAvatar()
            })

            single(.success(result))

            return disposeble

        }

    }

    func checkIfItemExist(searchText: String) -> Observable<Avatar?> {

        return  Observable<Avatar?>.create { observer in

            let managedContext = self.persistentContainer.viewContext
            let disposeble: Disposable = Disposables.create()
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

            fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", searchText)
            guard let result: [NSManagedObject] = try?  managedContext.fetch(fetchRequest)
            else {
                return disposeble

            }
            observer.onNext(result.first?.toAvatar())

            return disposeble
        }

        //        let managedContext = self.persistentContainer.viewContext
        //
        //        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        //
        //        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", searchText)
        //
        //        do {
        //            let result = try managedContext.fetch(fetchRequest)
        //            resultHandler(.success(result))
        //        } catch {
        //            print(error)
        //            resultHandler(.failure(error))
        //        }
    }
    func delete(avatar: Avatar) -> Completable {
        return Completable.create { completable in
            let managedContext = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
            fetchRequest.predicate = NSPredicate(format: "login = %@", avatar.login)

            do {
                let avatarToDelete = try? managedContext.fetch(fetchRequest)
                if avatarToDelete?.count == 1 {
                    guard let avatar = avatarToDelete?.first else { return Disposables.create {}}
                    managedContext.delete(avatar)
                    try? managedContext.save()
                }
            } catch {
                completable(.error(CoreDataError.fetchError))
                return Disposables.create {}
            }
            completable(.completed)
            return Disposables.create {}
        }
    }
}

//        let managedContext = self.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
//
//        fetchRequest.predicate = NSPredicate(format: "login = %@", avatarObject.login)
//
//        do {
//            let avatarToDelete = try managedContext.fetch(fetchRequest)
//            if avatarToDelete.count == 1 {
//                guard let avatar = avatarToDelete.first else { return }
//                managedContext.delete(avatar)
//                try managedContext.save()
//            }
//
//        } catch let error as NSError {
//            print("[DELETE AVATAR] Error to delete avatar: \(error)")
//        }
