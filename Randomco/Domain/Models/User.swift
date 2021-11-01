//
//  User.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Foundation

struct User: Hashable {
    let name: String
    let surname: String
    let email: String
    let smallPicture: String
    let largePicture: String
    let phone: String
    let gender: Gender
    let location: Location
    let registeredDate: String
    var favourite: Bool
    
    var fullName: String {
        name + " " + surname
    }
    
    var fullStreet: String {
        location.street.name + ", " + location.city + ", " + location.state
    }
}
