//
//  ContentView.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 20/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var persons: [Person] = [
    Person(name: "Rémi"),
    Person(name: "Camille"),
    Person(name: "Benjamin"),
    Person(name: "Sandrine"),
    Person(name: "Nicolas"),
    Person(name: "Nathalie"),
    Person(name: "Philippe"),
    Person(name: "Marie-France"),
    Person(name: "Le chat")
  ]
  
  var body: some View {
    NavigationView {
      Group {
        List {
          ForEach(persons, id: \.name) { person in
            NameListRow()
            .environmentObject(person)
          }
          NameListAddFooter { name in
            self.persons.append(Person(name: name))
          }
        }
      }.modifier(AdaptsToSoftwareKeyboard())
      
    .navigationBarTitle("What the gift")
      .navigationBarItems(trailing: Button(action: {
        let draw = Drawer().draw(self.persons)
        self.persons = draw
      }, label: {
        Text("Draw")
      }))
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
