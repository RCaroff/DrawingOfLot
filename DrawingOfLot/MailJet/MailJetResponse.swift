//
//  MailJetResponse.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 02/09/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation

enum MailJetError: Error {
  case send0003
  case send0004
  case send0006
  case send0007
  case send0008
  case send0010
  case send0011
  case send0012
  case send0013
  case send0015
  case send0016
  case mj0001
  case mj0002
  case mj0003
  case mj0005
  case mj0006
  case mj0007
  case mj0008
  case mj0011
  case mj0012
  case mj0013
  case mj0015
}

struct MailJetResponse: Decodable {
  var Messages: [MailJetResponseMessage]
}

struct MailJetResponseMessage: Decodable {
  var Status: String
  var Errors: [MailJetResponseMessageError]?
  var CustomID: String
  var To: [MailJetResponseMessageMailObject]
  var Cc: [MailJetResponseMessageMailObject]
  var Bcc: [MailJetResponseMessageMailObject]
}

struct MailJetResponseMessageError: Decodable {
  var ErrorIdentifier: String
  var ErrorCode: String
  var StatusCode: Int64
  var ErrorMessage: String
  var ErrorRelatedTo: [String]
}

struct MailJetResponseMessageMailObject: Decodable {
  var Email: String
  var MessageUUID: String
  var MessageID: Int64
  var MessageHref: String
}
