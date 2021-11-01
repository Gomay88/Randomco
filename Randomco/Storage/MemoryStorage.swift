//
//  MemoryStorage.swift
//  Randomco
//
//  Created by Víctor Jimenez on 31/10/21.
//

import Foundation

class MemoryStorage {
    static let shared = MemoryStorage()
    
    private var data: [String: Any] = [:]
    
    private init() {}
    
    func save(data: Any, key: String) {
        self.data[key] = data
    }
    
    func retrive(key: String) -> Any? {
        data[key]
    }
}
