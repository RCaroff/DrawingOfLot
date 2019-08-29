//
//  TextFieldAlert.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 23/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI

struct TextFieldAlert: View {
  
  typealias VoidClosure = (() -> Void)
  
  var inputText: Binding<String>
  var onValidate: VoidClosure
  var onSingle: VoidClosure
  
  var body: some View {
    VStack {
      Text("Qui est le/la conjoint(e) ?")
        .font(.headline)
        .padding(.bottom, CGFloat(30.0))
      TextField("Entrez le nom du conjoint...", text: inputText)
      Divider()
      .padding(.bottom, CGFloat(30.0))
      Button(action: {
        if self.inputText.wrappedValue.isEmpty {
          self.onSingle()
        } else {
          self.onValidate()
        }
      }, label: {
        self.inputText.wrappedValue.isEmpty ? Text("Célibataire ?") : Text("Valider")
      })
      
      Spacer()
    }
    .padding(.top, 50)
    .padding([.leading, .trailing], 20)
  }
}

struct TextFieldAlert_Previews: PreviewProvider {
  @State private var fieldValue: String = ""
    static var previews: some View {
      Text("Hello world")
//      TextFieldAlert(inputText: $fieldValue, onValidate: { name in
//
//      }) {
//
//      }
    }
}
