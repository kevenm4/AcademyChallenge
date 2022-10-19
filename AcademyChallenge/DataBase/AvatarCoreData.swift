//
//  AvatarCoreData.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 12/10/2022.

import CoreData
import UIKit

class AvatarCoreData {
	
	 var AvatarPersistence: [NSManagedObject] = []
	
	var appDelegate: AppDelegate
	
	init() {
		appDelegate = UIApplication.shared.delegate as! AppDelegate
	}
	
	func persist(currentAvatar: Avatar){
		
		DispatchQueue.main.async() {
	
			
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
	

		
	let managedContext = appDelegate.persistentContainer.viewContext
		
		let entity = NSEntityDescription.entity(forEntityName: "AvatarEntity", in: managedContext)!
		
		let avatar = NSManagedObject(entity: entity, insertInto: managedContext)
		
			avatar.setValue(currentAvatar.login, forKeyPath: "login")
		
			avatar.setValue(currentAvatar.avatarUrl.absoluteString, forKey: "avatarUrl")
			
			avatar.setValue(currentAvatar.id, forKey: "id")
		
		do {
			
		  try managedContext.save()
			
			//self.AvatarPersistence.append(avatar)
			
		} catch let error as NSError {
			
		  print("Could not save. \(error), \(error.userInfo)")
		}
		
	}
	}
		
	
		func fetch(_ resulthandler: @escaping ([NSManagedObject]) -> Void) {
			
			var array: [NSManagedObject]
			
//			   guard let appDelegate =
//
//				 UIApplication.shared.delegate as? AppDelegate else {
//
//				   return
//			   }

			   let managedContext =
				 appDelegate.persistentContainer.viewContext

			   // FETCH ALL THE DATA FROM THE ENTITY PERSON
			   let fetchRequest =
				 NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

			   // WE GET THE DATA THOUGH THE FETCHREQUEST CRITERIA, IN THIS CASE WE ASK THE MANAGED CONTEXT TO SEND ALL THE DATA FROM THE PERSON ENTITY
			   do {
				   array = try managedContext.fetch(fetchRequest)
				   
				   resulthandler(array)
				   
			   } catch let error as NSError{
				   
				 print("Could not fetch. \(error), \(error.userInfo)")
			   }

		   }
	
	func checkIfItemExist(searchText: String, _ resultHandler: @escaping (Result<[NSManagedObject],Error>) -> Void) {
		
		let managedContext = self.appDelegate.persistentContainer.viewContext
		
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
			
			let managedContext = self.appDelegate.persistentContainer.viewContext
			
			
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
