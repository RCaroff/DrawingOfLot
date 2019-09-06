//
//  AddPersonViewModel.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 02/09/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension String {
  func isReallyEmpty() -> Bool {
    return self.replacingOccurrences(of: " ", with: "").isEmpty
  }
}

final class AddPersonViewModel: ObservableObject {
  
  @ObservedObject var repository: PersonsRepository = .shared
  
  @Published var hasJoint: Bool = false
  
  @Published var nameInputText: String = ""
  @Published var emailInputText: String = ""
  @Published var jointNameInputText: String = ""
  @Published var jointEmailInputText: String = ""
  
  @Published var nameEmptyError: Bool = false
  @Published var emailEmptyError: Bool = false
  @Published var jointNameEmptyError: Bool = false
  @Published var jointEmailEmptyError: Bool = false
  var dismiss = PassthroughSubject<Void, Never>()
  
  func loadView() {
    nameInputText = repository.editingName
  }

  func validateButtonTapped() {
    guard validateFields() else { return }
    let person = Person(name: nameInputText)
    person.email = emailInputText
    if !hasJoint {
      repository.add(person: person)
      dismiss.send()
      return
    }
    
    person.joint = jointNameInputText
    let jointPerson = Person(name: jointNameInputText)
    jointPerson.email = jointEmailInputText
    jointPerson.joint = person.name
    
    repository.add(person: person)
    repository.add(person: jointPerson)
    dismiss.send()
  }
  
  private func validateFields() -> Bool {
    var isValid: Bool = true
    if nameInputText.isReallyEmpty() {
      isValid = false
      nameEmptyError = true
    }
    
    if emailInputText.isReallyEmpty() {
      isValid = false
      emailEmptyError = true
    }
    
    guard hasJoint else { return isValid }
    
    if jointNameInputText.isReallyEmpty() {
      isValid = false
      jointNameEmptyError = true
    }
    
    if jointEmailInputText.isReallyEmpty() {
      isValid = false
      jointEmailEmptyError = true
    }
    
    return isValid
  }
}
