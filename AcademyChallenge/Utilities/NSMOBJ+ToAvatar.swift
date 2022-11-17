//
//  NSMOBJ+ToAvatar.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 14/10/2022.
//

import Foundation

import CoreData

extension NSManagedObject {
    func toAvatar() -> Avatar? {
        guard let login = self.value(forKey: "login") as? String,
              let id = self.value(forKey: "id") as? Int,
              let avatarUrlString = self.value(forKey: "avatarUrl") as? String,
              let avatarUrl = URL(string: avatarUrlString) else {
            return nil
        }
        return Avatar(
            login: login,
            id: id,
            avatarUrl: avatarUrl
        )
    }
}
