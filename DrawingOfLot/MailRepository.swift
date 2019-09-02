//
//  MailRepository.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 30/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import Combine

enum MailRepositoryError: Error {
  case invalidURL
  case noResponseData
}

class MailRepository {
  
  let session: URLSession = URLSession.shared
  
  private lazy var authValue: String = {
    let raw = "fdcbcb0f699ede25605e46b54140cf5e:7848d2fff5e6a61d5cf5a19f2e974e88"
    let encoded = raw.data(using: String.Encoding.ascii)!
    return "Basic \(encoded.base64EncodedString())"
  }()
  
  func sendMail(mail: MessageList) -> Future<MailJetResponse, Error> {
    return Future { promise in
      do {
        guard let url = URL(string: "https://api.mailjet.com/v3.1/send") else {
          promise(.failure(MailRepositoryError.invalidURL))
          return
        }
        
        let data = try JSONEncoder().encode(mail)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(self.authValue, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = self.session.uploadTask(with: request, from: data) { (responseData, urlResponse, error) in
          if let error = error {
            promise(.failure(error))
          } else {
            guard let responseData = responseData else {
              promise(.failure(MailRepositoryError.noResponseData))
              return
            }
            do {
              let dataObject = try JSONDecoder().decode(MailJetResponse.self, from: responseData)
              promise(.success(dataObject))
            } catch (let error) {
              promise(.failure(error))
            }
          }
        }
        
        task.resume()

      } catch (let error) {
        promise(.failure(error))
      }
    }
  }
}
