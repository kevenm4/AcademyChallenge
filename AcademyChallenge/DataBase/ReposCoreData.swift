//
//  ReposEntity.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation
import UIKit
import CoreData

class ReposCoreData {
	
	var ReposPersistence: [NSManagedObject] = []
   
//   var appDelegate: AppDelegate
//   
//   init() {
//	   appDelegate = UIApplication.shared.delegate as! AppDelegate
//   }
   
	
	func persist(repositories : Repos){
		
	   
	   DispatchQueue.main.async() {
   
		   
	   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
   

	   
   let managedContext = appDelegate.persistentContainer.viewContext
		   
	   
	   let entity = NSEntityDescription.entity(forEntityName: "ReposEntity", in: managedContext)!
		   
	   
	   let repos = NSManagedObject(entity: entity, insertInto: managedContext)
	   
		   repos.setValue( repositories.fullName, forKeyPath: "fullName")
	   
		   repos.setValue(repositories.unique, forKey: "unique")
		   
		   repos.setValue( repositories.id, forKey: "id")
	   
	   do {
		   
		 try managedContext.save()
		   
		   self.ReposPersistence.append(repos)
		   
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
			 NSFetchRequest<NSManagedObject>(entityName: "ReposEntity")

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
