//
//  ListScreenViewModel.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 27/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ListScreenViewModel: ObservableObject {
  
  @ObservedObject var mailService: MailService = MailService()
  @ObservedObject var repository: PersonsRepository = .shared
  
  // Input
  @Published var nameTextFieldInput: String = ""
  
  // Output
  @Published var personViewModels: [PersonViewModel] = [] {
    didSet {
      nameTextFieldInput = ""
    }
  }
  @Published var isErrorAlertPresented: Bool = false
  @Published var isDeleteJointAlertPresented: Bool = false
  @Published var isJointViewPresented: Bool = false
  @Published var isEmailOnError: Bool = false
  @Published var isSendingEmails: Bool = false
  
  private var cancellables: [AnyCancellable] = []

  private var indexSetToDelete: IndexSet = IndexSet() {
    didSet {
      isDeleteJointAlertPresented = !indexSetToDelete.isEmpty
    }
  }
  
  var drawDisabled: Bool {
    repository.personsCount < 4
  }
  
  func viewAppeared() {
    let getData = self.repository.persons.map { persons -> [PersonViewModel] in
      persons.map {
        PersonViewModel(
          name: $0.name,
          joint: $0.joint,
          receiver: $0.receiver
        )
      }
    }.assign(to: \.personViewModels, on: self)
    
    let updated = self.repository.personDidUpdate.sink { (person, index) in
      self.personViewModels[index].joint = person.joint
      self.personViewModels[index].receiver = person.receiver
    }
    
    cancellables += [getData, updated]
  }

  
  func addButtonTapped() {
    repository.editingName = nameTextFieldInput
    isJointViewPresented = true
  }
  
  func drawButtonTapped() {
    guard !drawDisabled else {
      isErrorAlertPresented = true
      return
    }
    let draw = Drawer().draw(personViewModels)
    if draw.isEmpty {
      isErrorAlertPresented = true
    } else {
      for i in 0..<draw.count {
        self.repository.update(at: i, keypath: \.receiver, value: draw[i])
      }
    }
  }
  
  func delete(at indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    if repository.getPerson(at: index).isSingle {
      repository.deletePerson(at: indexSet)
      return
    }
    indexSetToDelete = indexSet
  }
  
  func deleteExcludingJoint() {
    guard let index = indexSetToDelete.first else { return }
    let personToDelete = repository.getPerson(at: index)
    repository.deletePerson(at: indexSetToDelete)
    guard let joint = repository.getJoint(forPersonName: personToDelete.name) else { return }
    repository.update(person: joint, keypath: \.joint, value: "")
  }
  
  func deleteIncludingJoint() {
    guard let index = indexSetToDelete.first else { return }
    let personToRemove = repository.getPerson(at: index)
    repository.deletePerson(withName: personToRemove.name)
    repository.deletePerson(withName: personToRemove.joint)
  }
  
  func sendEmails() {
    
    let messageList = MessageList()
    
    repository.personsData.forEach {
      let message = self.message(for: $0)
      messageList.Messages.append(message)
    }

    let cancellable = mailService.sendMail(mail: messageList)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { _ in
    }) { mailJetResponse in
      self.isEmailOnError = mailJetResponse.Messages.first!.Status != "success"
    }
    cancellables.append(cancellable)
  }
  
  private func message(for person: Person) -> Message {
    let message = Message()
    message.From = MailContact(Email: "remi.caroff@link-value.fr", Name: "Rémi Caroff Pro")
    message.To = [
      MailContact(Email: person.email, Name: person.name),
    ]
    message.Variables = MailVariables(name: person.name, receiver: person.receiver)
    
    return message
  }
}
