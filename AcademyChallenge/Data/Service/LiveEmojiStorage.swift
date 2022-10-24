//
//  LiveEmojiStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 29/09/2022.
//

import Foundation
import CoreData
import UIKit
class LiveEmojiStorage: EmojiService {

	private var emojiNetwork: Network = .init()
	
	private let persistence: EmojiCoreData = .init()
//
//	var emojis: [Emoji] = []
	
	func persistEmjis(emojis: [Emoji]){
		emojis.forEach { emoji in
			persistence.persist(name: emoji.name, imageUrl: emoji.imageUrl.absoluteString)
		}
	}
	
	func fetchEmojis (_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void){
		
		   var fetchedEmojis : [NSManagedObject] = []
		   fetchedEmojis = persistence.fetch()
		   
		   
		   if !fetchedEmojis.isEmpty {
			   let emojis = fetchedEmojis.map({ item in
				   return Emoji(name: item.value(forKey: "name") as! String, imageUrl: URL(string: item.value(forKey: "imageUrl") as! String)!)
			   })
			   print(emojis.count)
			   resultHandler(.success(emojis))
			   
		   }else {
			   // METHOD IN EMOJI API
				   emojiNetwork.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojiResponse, Error>) in
					   switch result{
					   case .success(let success):
	   //                    print("Success: \(success.emojis)")
						   self.persistEmjis(emojis: success.emojis)
						   resultHandler(.success(success.emojis))
					   case .failure(let failure):
						   print("Failure: \(failure)")
						
						   resultHandler(.failure(failure))
					   }
				   }
		   }
		
		   
	   }
	
	func deleteEmoji(emojiToDelete: Emoji) {
		 
		 persistence.delete(emojiObject:emojiToDelete)
	 }
	
	
	   }






