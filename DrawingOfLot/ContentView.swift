//
//  ContentView.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 20/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State var persons: [Person] = []
  @State private var isErrorAlertPresented: Bool = false
  @State private var isDeleteJointAlertPresented: Bool = false
  @State private var isJointViewPresented: Bool = false
  @State private var jointTextFieldValue: String = ""
  @State private var nameTextFieldValue: String = ""
  @State private var indexSetToDelete: IndexSet = IndexSet() {
    didSet {
      isDeleteJointAlertPresented = (!_indexSetToDelete.wrappedValue.isEmpty)
    }
  }
  
  var drawDisabled: Bool {
    persons.count < 4
  }
  
  var body: some View {
    NavigationView {
      Group {
        List {
          ForEach(persons, id: \.name) { person in
            NameListRow()
              .environmentObject(person)
          }
          .onDelete(perform: delete)
          NameListAddFooter(textFieldValue: $nameTextFieldValue) {
            self.isJointViewPresented = true
          }
        }
        .listStyle(GroupedListStyle())
      }
      .navigationBarTitle("What the gift")
      .navigationBarItems(
        trailing: Button(action: {
          guard self.persons.count >= 4 else {
            self.isErrorAlertPresented = true
            return
          }
          let draw = Drawer().draw(self.persons)
          if draw.isEmpty {
            self.isErrorAlertPresented = true
          } else {
            self.persons = draw
          }
        }, label: {
          Text("Draw")
        }
        )
      )
    }
    .modifier(AdaptsToSoftwareKeyboard())
    .alert(isPresented: $isErrorAlertPresented) {
      Alert(title: Text("Attention"),
            message: Text("Vous devez ajouter au moins 4 personnes à tirer au sort."),
            dismissButton: Alert.Button.cancel(Text("J'ai compris")))
      
    }
    .actionSheet(isPresented: $isDeleteJointAlertPresented) {
      ActionSheet(title: Text("Attention"),
                  message: Text("Souhaitez-vous également supprimer le conjoint de cette personne ?"),
                  buttons: [
                    ActionSheet.Button.destructive(Text("Oui"), action: {
                      self.deleteIncludingJoint(at: self.indexSetToDelete)
                    }),
                    ActionSheet.Button.default(Text("Non"), action: {
                      self.deleteExcludingJoint(at: self.indexSetToDelete)
                    }),
                    ActionSheet.Button.cancel(Text("Annuler"))
                  ]
      )
    }
    .sheet(isPresented: $isJointViewPresented, content: { () -> TextFieldAlert in
      UIApplication.shared.keyWindow?.endEditing(true)
      let person = Person(name: self.nameTextFieldValue)
      return TextFieldAlert(
        inputText: self.$jointTextFieldValue,
        onValidate: {
          person.joint = self.jointTextFieldValue
          self.persons.append(person)
          let jointPerson = Person(name: self.jointTextFieldValue)
          jointPerson.joint = self.nameTextFieldValue
          self.persons.append(jointPerson)
          self.isJointViewPresented = false
          self.jointTextFieldValue = ""
          self.nameTextFieldValue = ""
      }) {
        self.persons.append(person)
        self.isJointViewPresented = false
        self.nameTextFieldValue = ""
      }
    })
  }
  
  func delete(at indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    if persons[index].joint.isEmpty {
      persons.remove(at: index)
      return
    }
    indexSetToDelete = indexSet
  }
  
  func deleteExcludingJoint(at indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let personToRemoveJoint = "\(persons[index].joint)"
    persons.remove(atOffsets: indexSet)
    guard let indexOfJoint = persons.firstIndex(where: { $0.name == personToRemoveJoint }) else { return }
    persons[indexOfJoint].joint = ""
  }
  
  func deleteIncludingJoint(at indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let personToRemove = persons[index]
    persons.removeAll { $0.name == personToRemove.joint || $0.name == personToRemove.name }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let remi = Person(name: "Rémi")
    remi.joint = "Camille"
    remi.receiver = "Benjamin"
    let benjamin = Person(name: "Benjamin")
    benjamin.joint = "Sandrine"
    benjamin.receiver = "Rémi"
    let nicolas = Person(name: "Nicolas")
    nicolas.joint = "Nathalie"
    nicolas.receiver = "Philippe"
    let philippe = Person(name: "Philippe")
    philippe.joint = "Marie-France"
    philippe.receiver = "Nicolas"
    let camille = Person(name: "Camille")
    camille.joint = "Rémi"
    camille.receiver = "Sandrine"
    let sandrine = Person(name: "Sandrine")
    sandrine.joint = "Benjamin"
    sandrine.receiver = "Camille"
    let nathalie = Person(name: "Nathalie")
    nathalie.joint = "Nicolas"
    nathalie.receiver = "Marie-France"
    let marieFrance = Person(name: "Marie-France")
    marieFrance.joint = "Philippe"
    marieFrance.receiver = "Nathalie"
    
    return ContentView(persons: [
      remi,
      camille,
      benjamin,
      sandrine,
      nicolas,
      nathalie,
      philippe,
      marieFrance
    ])
  }
}
#endif
