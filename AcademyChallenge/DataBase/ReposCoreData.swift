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
   
   var appDelegate: AppDelegate
   
   init() {
	   appDelegate = UIApplication.shared.delegate as! AppDelegate
   }
   
	func persist(id: Int, full_name: String , private: Bool){
	   
	   DispatchQueue.main.async() {
   
		   
	   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
   

	   
   let managedContext = appDelegate.persistentContainer.viewContext
	   
	   let entity = NSEntityDescription.entity(forEntityName: "ReposEntity", in: managedContext)!
	   
	   let repos = NSManagedObject(entity: entity, insertInto: managedContext)
	   
		   repos.setValue( full_name, forKeyPath: "full_name")
	   
		   repos.setValue(`private`, forKey: "private")
		   
		   repos.setValue( id, forKey: "id")
	   
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
				NSFetchRequest<NSManagedObject>(entityName: "ReposEntity")

			  // WE GET THE DATA THOUGH THE FETCHREQUEST CRITERIA, IN THIS CASE WE ASK THE MANAGED CONTEXT TO SEND ALL THE DATA FROM THE PERSON ENTITY
			  do {
				  array = try managedContext.fetch(fetchRequest)
				  
				  resulthandler(array)
				  
			  } catch let error as NSError{
				  
				print("Could not fetch. \(error), \(error.userInfo)")
			  }

		  }
	
}
