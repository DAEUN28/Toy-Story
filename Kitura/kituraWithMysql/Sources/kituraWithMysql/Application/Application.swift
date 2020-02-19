import Kitura
import KituraContracts
import SwiftKueryMySQL
import SwiftKuery

public class App {

  static let poolOptions = ConnectionPoolOptions(initialCapacity: 1, maxCapacity: 5)
  static var idStore = -1
  
  private let router = Router()
  private let pool = MySQLConnection.createPool(user: "root",
                                                password: "1128",
                                                database: "User",
                                                poolOptions: poolOptions)
  private let userTable = UserTable()

  public init() {
    router.post("/me", handler: self.postHandler)
    router.delete("/me", handler: self.deleteHandler)
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

      let id = App.idStore + 1

      let query = Insert(into: self.userTable,
                         columns: [Column("id"), Column("name")],
                         values: [id, name.name])
      connection.execute(query: query) { result in
        if let val = result.asValue {
          App.idStore += 1
          print(val)
          connection.closeConnection()
          completion(ID(id: id), .created)
        }
      }
    }
  }

  func deleteHandler(query: IDQuery, completion: @escaping (RequestError?) -> Void) {

  }
}
