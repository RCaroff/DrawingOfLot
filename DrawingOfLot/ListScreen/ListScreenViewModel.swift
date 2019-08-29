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
  
  // Input
  @Published var nameTextFieldInput: String = ""
  @Published var jointTextFieldInput: String = ""
  
  // Output
  let didChange = PassthroughSubject<ListScreenViewModel, Never>()
  
  @Published var personViewModels: [PersonViewModel] = []
  @Published var isErrorAlertPresented: Bool = false
  @Published var isDeleteJointAlertPresented: Bool = false
  @Published var isJointViewPresented: Bool = false
  
  private var persons: [Person] = []
  
  private var indexSetToDelete: IndexSet = IndexSet() {
    didSet {
      isDeleteJointAlertPresented = !indexSetToDelete.isEmpty
    }
  }
  
  var drawDisabled: Bool {
    persons.count < 4
  }
  
  func validateTapped() {
    let person = Person(name: nameTextFieldInput)
    person.joint = jointTextFieldInput
    persons.append(person)
    let jointPerson = Person(name: jointTextFieldInput)
    jointPerson.joint = nameTextFieldInput
    persons.append(jointPerson)
    isJointViewPresented = false
    jointTextFieldInput = ""
    nameTextFieldInput = ""
    updateUI()
  }
  
  func singleTapped() {
    let person = Person(name: nameTextFieldInput)
    persons.append(person)
    isJointViewPresented = false
    nameTextFieldInput = ""
    updateUI()
  }
  
  func addButtonTapped() {
    isJointViewPresented = true
  }
  
  func drawButtonTapped() {
    guard !drawDisabled else {
      isErrorAlertPresented = true
      return
    }
    let draw = Drawer().draw(persons)
    if draw.isEmpty {
      isErrorAlertPresented = true
    } else {
      persons = draw
      updateReceivers()
    }
  }
  
  func delete(at indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    if persons[index].joint.isEmpty {
      persons.remove(at: index)
      updateUI()
      return
    }
    indexSetToDelete = indexSet
  }
  
  func deleteExcludingJoint() {
    guard let index = indexSetToDelete.first else { return }
    let personToRemoveJoint = "\(persons[index].joint)"
    persons.remove(atOffsets: indexSetToDelete)
    guard let indexOfJoint = persons.firstIndex(where: {
      $0.name == personToRemoveJoint
    }) else { return }
    persons[indexOfJoint].joint = ""
    updateUI()
  }
  
  func deleteIncludingJoint() {
    guard let index = indexSetToDelete.first else { return }
    let personToRemove = persons[index]
    persons.removeAll { $0.name == personToRemove.joint || $0.name == personToRemove.name }
    updateUI()
  }
  
  private func updateReceivers() {
    for i in 0..<persons.count {
      personViewModels[i].receiver = persons[i].receiver
    }
  }
  
  private func updateUI() {
    personViewModels = persons.map {
      PersonViewModel(
        name: $0.name,
        joint: $0.joint,
        receiver: $0.receiver
      )
    }
  }
}
