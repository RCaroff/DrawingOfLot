//
//  NameListRow.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 21/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI
import Combine

struct NameListRow: View {
  
//  @State var leftValue: String = ""
//  @State var rightValue: String = ""
  
  @EnvironmentObject private var person: Person
  
  var body: some View {
    HStack {
      Text(person.name).bold()
      Text("🎁 →")
        .font(.system(size: 30))
        .multilineTextAlignment(.center)
        
      Spacer()
      Text(person.receiver).bold()
    }
    .padding()
  }
}

struct NameListRow_Previews: PreviewProvider {
  static var previews: some View {
    let person = Person(name: "Rémi")
    person.receiver = "Nicolas"
    return NameListRow()
    .environmentObject(person)
  }
}
