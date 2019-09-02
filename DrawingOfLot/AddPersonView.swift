//
//  TextFieldAlert.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 23/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI

struct AddPersonView: View {
  
  typealias VoidClosure = (() -> Void)
  
  @Binding var inputText: String
  var onValidate: VoidClosure
  var onSingle: VoidClosure
  
  var body: some View {
    VStack {
      Text("Qui est le/la conjoint(e) ?")
        .font(.headline)
        .padding(.bottom, CGFloat(30.0))
      TextField("Entrez le nom du conjoint...", text: $inputText)
      Divider()
      .padding(.bottom, CGFloat(30.0))
      Button(action: {
        if self.$inputText.wrappedValue.isEmpty {
          self.onSingle()
        } else {
          self.onValidate()
        }
      }, label: {
        self.$inputText.wrappedValue.isEmpty ? Text("Célibataire ?") : Text("Valider")
      })
      
      Spacer()
    }
    .padding(.top, 50)
    .padding([.leading, .trailing], 20)
  }
}

struct TextFieldAlert_Previews: PreviewProvider {
  
    static var previews: some View {
      AddPersonView(inputText: .constant("Camille"), onValidate: {
        
      }) {
        
      }
    }
}
