//
//  ConstantsError.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 22/11/2022.
//

import Foundation

enum CoreDataError: Error {
    case fetchError
}

enum DeleteError: Error {
    case parse
    case unauthorized
}
