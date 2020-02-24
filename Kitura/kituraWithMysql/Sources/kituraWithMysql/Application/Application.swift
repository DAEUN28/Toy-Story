import Foundation

import Kitura
import KituraContracts
import SwiftKueryMySQL
import SwiftKuery

public class App {

  private static let poolOptions = ConnectionPoolOptions(initialCapacity: 1, maxCapacity: 5)
  private static let connectionURL = URL(string: "mysql://root:1128@127.0.0.1:5252/KituraWithMysql")!

  private let pool = MySQLConnection.createPool(url: connectionURL, poolOptions: poolOptions)
  private let userTable = UserTable()

  private let router = Router()

  public init() {
    router.post("/me", handler: self.postHandler)
//    router.delete("/me", handler: self.deleteHandler)
  }

  public func run() {
    Kitura.addHTTPServer(onPort: 8080, with: router)
    Kitura.run()
  }
}

extension App {
  func postHandler(name: Name, completion: @escaping (ID?, RequestError?) -> Void) {
    self.pool.getConnection { [weak self] connection, error in
      guard let connection = connection, let self = self else { return completion(nil, .internalServerError) }

      let insertQuery = Insert(into: self.userTable, columns: [self.userTable.name], values: [name.name])
      let getIDQuery = Select(self.userTable.id, from: self.userTable)
        .where(self.userTable.name == name.name)

      connection.execute(query: insertQuery) { result in
        if result.asError != nil {
          return completion(nil, .internalServerError)
        }

        connection.execute(query: getIDQuery) { result in
          guard let resultSet = result.asResultSet else { return completion(nil, .internalServerError) }
          resultSet.forEach() { row, _ in
            guard let row = row, let id = row.first as? Int32 else { return completion(nil, .internalServerError) }
            return completion(ID(id: Int(id)), .created)
          }
        }
      }
    }
  }

  func deleteHandler(query: IDQuery, completion: @escaping (RequestError?) -> Void) {

  }
}
