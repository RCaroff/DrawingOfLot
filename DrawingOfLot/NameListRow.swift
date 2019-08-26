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
    VStack(alignment: .center) {
      HStack(alignment: .center) {
        VStack(alignment: .leading) {
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
        Spacer(minLength: 16)
        Text(person.receiver).bold()
          .animation(
            .spring(
              response: 0.2,
              dampingFraction: 0.3,
              blendDuration: 1
            )
          )
      }
      .padding(.horizontal, 0)
    }
    .padding(.vertical, 10)
  }
}

struct NameListRow_Previews: PreviewProvider {
  static var previews: some View {
    let philippe = Person(name: "Philippe")
    philippe.joint = "Marie-France"
    //philippe.receiver = "Nicolas"
    return NameListRow() 
      .environmentObject(philippe)
  }
}
