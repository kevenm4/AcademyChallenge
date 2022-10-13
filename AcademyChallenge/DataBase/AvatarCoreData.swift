//
//  AvatarCoreData.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 12/10/2022.

import CoreData
import UIKit

class AvatarCoreData {
	
	 var AvatarPersistence: [NSManagedObject] = []
	
	
	func persist(login: String, id:Int16 ,avatar_url: String){
		
		DispatchQueue.main.async() {
	
			
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
	

		
	let managedContext = appDelegate.persistentContainer.viewContext
		
		let entity = NSEntityDescription.entity(forEntityName: "AvatarEntity", in: managedContext)!
		
		let avatar = NSManagedObject(entity: entity, insertInto: managedContext)
		
		avatar.setValue(login, forKeyPath: "login")
		
		avatar.setValue(avatar_url, forKey: "avatar_url")
		
		do {
			
		  try managedContext.save()
			
			self.AvatarPersistence.append(avatar)
			
		} catch let error as NSError {
			
		  print("Could not save. \(error), \(error.userInfo)")
		}
		
	}
	}
		
	
		func fetch() {
			
			//   var array: [NSManagedObject] = []
			
			   guard let appDelegate =
						
				 UIApplication.shared.delegate as? AppDelegate else {
				   
				   return
			   }

			   let managedContext =
				 appDelegate.persistentContainer.viewContext

			   // FETCH ALL THE DATA FROM THE ENTITY PERSON
			   let fetchRequest =
				 NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

			   // WE GET THE DATA THOUGH THE FETCHREQUEST CRITERIA, IN THIS CASE WE ASK THE MANAGED CONTEXT TO SEND ALL THE DATA FROM THE PERSON ENTITY
			   do {
				   AvatarPersistence = try managedContext.fetch(fetchRequest)
				   
			   } catch let error as NSError{
				   
				 print("Could not fetch. \(error), \(error.userInfo)")
			   }

		   }
	
	func checkIfItemExist(login: String) -> Bool {
			guard let appDelegate =
			  UIApplication.shared.delegate as? AppDelegate else {
			  return false
			}
			
			let managedContext =
			  appDelegate.persistentContainer.viewContext
			
			let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "AvatarEntity")
			fetchRequest.predicate = NSPredicate(format: "login = %@", login)
			
			do {
				let test = try managedContext.fetch(fetchRequest)
				if test.isEmpty {
					return false
				}
			} catch {
				print(error)
			}
			return true
		}
	
	}
