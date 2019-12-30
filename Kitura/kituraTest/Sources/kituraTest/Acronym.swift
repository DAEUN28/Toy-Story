//
//  Acronym.swift
//
//
//  Created by baby1234 on 2019/12/30.
//

import CouchDB

struct Acronym: Document {
  let _id: String?
  var _rev: String?
  var short: String
  var long: String
}
