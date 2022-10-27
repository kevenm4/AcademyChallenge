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
	
	var appDelegate: AppDelegate {
		
		UIApplication.shared.delegate as! AppDelegate
	}
	
	
	
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
	
	
	func delete(emojiObject: Emoji) {
		
		let managedContext = self.appDelegate.persistentContainer.viewContext
		
		
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
