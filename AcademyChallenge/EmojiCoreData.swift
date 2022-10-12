//
//  EmojiCoreData.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 11/10/2022.
//

import CoreData
import UIKit

class EmojiCoreData {
	
	 var EmojiPersistence: [NSManagedObject] = []
	
	
	func persist(name: String, imageUrl: String){
		
		DispatchQueue.main.async() {
	
			
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
	

		
	let managedContext = appDelegate.persistentContainer.viewContext
		
		let entity = NSEntityDescription.entity(forEntityName: "EmojiEntity", in: managedContext)!
		
		let emoji = NSManagedObject(entity: entity, insertInto: managedContext)
		
		emoji.setValue(name, forKeyPath: "name")
		
		emoji.setValue(imageUrl, forKey: "imageUrl")
		
		do {
			
		  try managedContext.save()
			
			self.EmojiPersistence.append(emoji)
			
		} catch let error as NSError {
			
		  print("Could not save. \(error), \(error.userInfo)")
		}
		
	}
	}
		
	
		func fetch() -> [NSManagedObject] {
			   var array: [NSManagedObject] = []
			   guard let appDelegate =
				 UIApplication.shared.delegate as? AppDelegate else {
				   return array
			   }

			   let managedContext =
				 appDelegate.persistentContainer.viewContext

			   // FETCH ALL THE DATA FROM THE ENTITY PERSON
			   let fetchRequest =
				 NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

			   // WE GET THE DATA THOUGH THE FETCHREQUEST CRITERIA, IN THIS CASE WE ASK THE MANAGED CONTEXT TO SEND ALL THE DATA FROM THE PERSON ENTITY
			   do {
				   array = try managedContext.fetch(fetchRequest)
			   } catch let error as NSError {
				 print("Could not fetch. \(error), \(error.userInfo)")
			   }

			   return array
		   }
//
	
	}
