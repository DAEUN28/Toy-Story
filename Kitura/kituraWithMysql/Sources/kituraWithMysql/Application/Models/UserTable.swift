import SwiftKuery
import SwiftKueryMySQL

class UserTable: Table {
  let tableName = "UserTable"
  let id = Column("id", Int32.self, primaryKey: true)
  let name = Column("name", String.self)
}
