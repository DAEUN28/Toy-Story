//
//  Application.swift
// 
//
//  Created by baby1234 on 2019/12/26.
//

import CouchDB
import Foundation
import Kitura
import LoggerAPI

public class App {

  var client: CouchDBClient?
  var database: Database?

  let router = Router()

  private func postInit() {
    let connectionProperties = ConnectionProperties(host: "localhost",
                                                    port: 5984,
                                                    secured: false)
    client = CouchDBClient(connectionProperties: connectionProperties)
    client!.retrieveDB("acronyms") { database, error in
      guard let database = database else {
        Log.info("Could not retrieve acronym database: "
          + "\(String(describing: error?.localizedDescription)) "
          + "- attempting to create new one.")
        self.createNewDatabase()
        return
      }
      Log.info("Acronyms database located - loading...")
      self.finalizeRoutes(with: database)
    }
  }

  private func createNewDatabase() {
    client?.createDB("acronyms") { database, error in
      guard let database = database else {
        Log.error("Could not create new database: "
          + "(\(String(describing: error?.localizedDescription))) "
          + "- acronym routes not created")
        return
      }
      self.finalizeRoutes(with: database)
    }
  }

  private func finalizeRoutes(with database: Database) {
    self.database = database
    initializeAcronymRoutes(app: self)
    Log.info("Acronym routes created")
  }

  public func run() {
    postInit()
    Kitura.addHTTPServer(onPort: 8080, with: router)
    Kitura.run()
  }
}
