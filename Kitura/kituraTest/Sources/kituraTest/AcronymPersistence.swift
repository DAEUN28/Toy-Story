//
//  AcronymPersistence.swift
//  
//
//  Created by baby1234 on 2019/12/30.
//

import Foundation
import CouchDB
import LoggerAPI

extension Acronym {
  class Persistence {
    static func getAll(from database: Database, callback: @escaping (_ acronyms: [Acronym]?, _ error: Error?) -> Void) {
      database.retrieveAll(includeDocuments: true) { documents, error in
        guard let documents = documents else {
          Log.error("Error retrieving all documents: \(String(describing: error))")
          return callback(nil, error)
        }
        let acronyms = documents.decodeDocuments(ofType: Acronym.self)
        callback(acronyms, nil)
      }
    }

    static func save(_ acronym: Acronym, to database: Database, callback: @escaping (_ acronym: Acronym?, _ error: Error?) -> Void) {
      database.create(acronym) { document, error in
        guard let document = document else {
          Log.error("Error creating new document: \(String(describing: error))")
          return callback(nil, error)
        }
        database.retrieve(document.id, callback: callback)
      }
    }

    static func delete(_ acronymID: String, from database: Database, callback: @escaping (_ error: Error?) -> Void) {
        database.retrieve(acronymID) { (acronym: Acronym?, error: CouchDBError?) in
          guard let acronym = acronym, let acronymRev = acronym._rev else {
            Log.error("Error retrieving document: \(String(describing:error))")
            return callback(error)
          }
          database.delete(acronymID, rev: acronymRev, callback: callback)
        }
    }
  }
}
