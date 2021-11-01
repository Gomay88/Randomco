//
//  UsersResponse.swift
//  Randomco
//
//  Created by Víctor Jimenez on 30/10/21.
//

import Foundation

enum Gender: String, Codable {
    case male = "male"
    case female = "female"
}

struct UsersResponse: Codable {
    let results: [Results]
    let info: Info
    
    struct Results: Codable {
        let gender: Gender
        let name: Name
        let location: Location
        let email: String
        let login: Login
        let dob, registered: Dob
        let phone, cell: String
        let id: ID
        let picture: Picture
        let nat: String
    }
    
    struct Info: Codable {
        let seed: String
        let results: Int
        let page: Int
        let version: String
    }
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable, Hashable {
    let street: Street
    let city: String
    let state: String
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Street: Codable, Hashable {
    let number: Int
    let name: String
}

struct Coordinates: Codable, Hashable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable, Hashable {
    let offset: String
    let description: String
}

struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct Dob: Codable {
    let date: String
    let age: Int
}

struct ID: Codable {
    let name: String
    let value: String?
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
