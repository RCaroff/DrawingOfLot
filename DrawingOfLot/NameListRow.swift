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
  
  @EnvironmentObject private var person: Person
  
  var body: some View {
    HStack {
      VStack {
        Text(person.name).bold()
        if !person.isSingle {
          Text("❤️ \(person.joint)")
            .font(.system(size: 12))
            .foregroundColor(.gray)
        }
      }
      Text("🎁 →")
        .font(.system(size: 30))
        .multilineTextAlignment(.center)
      
      Spacer()
      Text(person.receiver).bold()
        .animation(
          .spring(
            response: 0.2,
            dampingFraction: 0.3,
            blendDuration: 1
          )
        )
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
