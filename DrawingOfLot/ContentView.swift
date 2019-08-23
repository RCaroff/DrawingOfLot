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
  @State var isErrorAlertPresented: Bool = false
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
          NameListAddFooter { name in
            UIApplication.shared.keyWindow?.endEditing(true)
            let person = Person(name: name)
            TextFieldAlert(
              onValidate: { jointName in
                person.joint = jointName
                self.persons.append(person)
                let jointPerson = Person(name: jointName)
                jointPerson.joint = name
                self.persons.append(jointPerson)
            }) {
              self.persons.append(person)
            }
            .present(
            )
          }
        }
      }
      .navigationBarTitle("What the gift")
      .navigationBarItems(
        trailing: Button(action: {
          let draw = Drawer().draw(self.persons)
          if draw.count > 0 {
            self.persons = draw
          } else {
            self.isErrorAlertPresented = true
          }
        }, label: {
          Text("Draw")
          })
          .disabled(drawDisabled))
    }.modifier(AdaptsToSoftwareKeyboard())
    .alert(isPresented: $isErrorAlertPresented) {
      Alert(title: Text("Attention"),
            message: Text("Vous devez ajouter au moins 4 personnes à tirer au sort."),
            dismissButton: Alert.Button.cancel(Text("J'ai compris")))
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
