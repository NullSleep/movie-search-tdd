//
//  DBManager.swift
//  movie-search-tdd
//
//  Created by Carlos Arenas on 3/18/18.
//  Copyright © 2018 Carlos Arenas. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    // MARK: - Properties
    private var database:Realm
    static let sharedInstance = DBManager()
    
    // MARK: - Initializer
    private init() {
        database = try! Realm()
    }
    
    // MARK: - Public Functions
    func save(object: SearchTerm) -> Bool {
        do {
            try database.write {
                database.add(object, update: true)
            }
            return true
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        return false
    }
    
    func retrieve() -> Results<SearchTerm> {
        let results: Results<SearchTerm> = database.objects(SearchTerm.self)
        return results
    }
    
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: SearchTerm)   {
        try! database.write {
            database.delete(object)
        }
    }
}

class SearchTerm: Object {
    @objc dynamic var name: String = ""
    
    override class func primaryKey() -> String? {
        return "name"
    }
}

