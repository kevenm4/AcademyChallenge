//
//  NSMOBJ+ToEmoji.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 02/11/2022.
//

import CoreData

extension NSManagedObject {
    func toEmoji() -> Emoji? {
        guard let name = self.value(forKey: "name") as? String,
                let imageUrlString = self.value(forKey: "imageUrl") as? String,
              let imageUrl = URL(string: imageUrlString) else {
            return nil
        }
        return Emoji(
            name: name,
            imageUrl: imageUrl
        )
    }
}
