//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

indirect enum EmojiAsEnum {
	case anEmoji(image: String?, name: String?)
	case anotherEmoji(int: Int)
	case yetAnotherEmoji(emoji: [EmojiAsEnum])
	func displayName(for language: String) -> String {
		if language == "pt" {
			switch self {
			case .anEmoji(let image, let name):
				return "pt Yet Another Emoji"
			case .anotherEmoji:
				return "pt Another Emoji"
			case .yetAnotherEmoji(let emoji):
				return "pt Yet Another Emoji"
			}
		} else {
			switch self {
			case .anEmoji(let image, let name):
				return "en Yet Another Emoji"
			case .anotherEmoji:
				return "en Another Emoji"
			case .yetAnotherEmoji(let emoji):
				return "en Yet Another Emoji"
			}
		}
	}
	
}

extension EmojiAsEnum {
	var displayName: String {
		switch self {
		case .anEmoji(let image, let name):
			return "Yet Another Emoji"
		case .anotherEmoji:
			return "Another Emoji"
		case .yetAnotherEmoji(let emoji):
			return "Yet Another Emoji"
		}
	}
}
struct EmojiAsStruct: Equatable {
	var image: String?
	var name: String?
	
	func businessLogic() {
		
	}
}

class EmojiAsClass: Equatable {
	static func == (lhs: EmojiAsClass, rhs: EmojiAsClass) -> Bool {
		lhs.name == rhs.name && lhs.image == rhs.image
	}
	
	var image: String?
	var name: String?
	
	init(image: String?, name: String?) {
		self.image = image
		self.name = name
	}
	func businessLogic() {
		
	}
	
	
}

class EmojiListViewController: UIViewController, Coordinating {
	var coordinator: Coordinator?
	
	var emojiAsEnumList: [EmojiAsEnum] = []
	var emojiAsStructList: [EmojiAsStruct] = []
	var emojiAsClassList: [EmojiAsClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .blue
        // Do any additional setup after loading the view.
		
		emojiAsEnumList = [.anEmoji(image: "", name: "")]
		emojiAsStructList = [.init(image: "", name: "")]
		emojiAsClassList = [.init(image: "", name: "")]
		
		let a: EmojiAsClass = .init(image: "1", name:"1️⃣")
		let b: EmojiAsClass = .init(image: "1", name:"1️⃣")
		
		let a1: EmojiAsStruct = .init(image: "1", name:"1️⃣")
		let b1: EmojiAsStruct = .init(image: "1", name:"1️⃣")
		
		let c: EmojiAsEnum = .anEmoji(image: "3", name: "😃")
		
		title = c.displayName(for: "en")
		
		switch c {
		case .anEmoji(let image, let name):
			print("\(image) \(name)")
		default:
			print("asd")
		}
		
		print(a == b) //ruben: true, keven: true, daniel: true, janela: true
		print(a === b) //all:false
		
		print(a1 == b1) //ruben: true, keven: true, daniel: true, janela: true
    }

}
