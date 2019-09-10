//
//  Messages.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 30/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

/*
 curl -s \
 -X POST \
 --user "$MJ_APIKEY_PUBLIC:$MJ_APIKEY_PRIVATE" \
 https://api.mailjet.com/v3.1/send \
 -H 'Content-Type: application/json' \
 -d '{
   "Messages":[
     {
       "From": {
         "Email": "remi.caroff@link-value.fr",
         "Name": "Rémi"
       },
       "To": [
         {
           "Email": "passenger1@example.com",
           "Name": "passenger 1"
         }
       ],
       "TemplateID": 980806,
       "TemplateLanguage": true,
       "Subject": "Secret Santa !",
       "Variables": {
   "name": "",
   "receiver": "PERSONNE"
   }
     }
   ]
 }'
 */

import Foundation

class MessageList: Encodable {
  var SandboxMode: Bool = true
  var Messages: [Message] = []
}

class Message: Encodable {
  var From: MailContact = MailContact(Email:  InfoPlistHelper.infoForKey("MailJetSenderEmail") ?? "",
                                      Name: InfoPlistHelper.infoForKey("MailJetSenderName") ?? "")
  var To: [MailContact] = []
  let TemplateID: Int64 = Int64(InfoPlistHelper.infoForKey("MailJetTemplateID") ?? "0") ?? 0
  let TemplateLanguage: Bool = true
  var Subject: String = "Secret Santa chez les Carottes !"
  var Variables: MailVariables = MailVariables()
}

struct MailContact: Encodable {
  var Email: String
  var Name: String
}

struct MailVariables: Encodable {
  var name: String = ""
  var receiver: String = ""
}
