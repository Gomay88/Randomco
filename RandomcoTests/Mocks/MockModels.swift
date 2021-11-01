//
//  MockModels.swift
//  RandomcoTests
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation
@testable import Randomco

struct MockModels {
    static var MockUser: User {
        let street = Street(number: 1, name: "House")
        let coordinates = Coordinates(latitude: "", longitude: "")
        let timezone = Timezone(offset: "", description: "")
        let location = Location(
            street: street,
            city: "Madrid",
            state: "Madrid",
            coordinates: coordinates,
            timezone: timezone)
        
        return User(
            name: "Victor",
            surname: "J",
            email: "vjg@vjg.com",
            smallPicture: "",
            largePicture: "",
            phone: "666666666",
            gender: .male,
            location: location,
            registeredDate: "31/10/2020",
            favourite: false)
    }
}
