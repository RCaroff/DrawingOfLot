//
//  NameListAddFooter.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 21/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI

struct NameListAddFooter: View {
  
  @State private var textFieldValue: String = ""
  @State private var isAlertPresented: Bool = false
  @State private var alertFieldValue: String = ""
  
  var addAction: ((String) -> ())
  
  var body: some View {
    HStack {
      TextField("Ajoutez un nom", text: $textFieldValue)
        .padding()
        
      Button(action: {
        if self.textFieldValue
          .replacingOccurrences(of: " ", with: "")
          .count > 0 {
          self.addAction(self.textFieldValue)
          self.textFieldValue = ""
        }
      }
      ) {
        Text("+")
          .font(.system(size: 30))
          .foregroundColor(.blue)
          .frame(width: 50, height: 50, alignment: .trailing)
      }
      .padding()
    
    }
  }
}

struct NameListAddFooter_Previews: PreviewProvider {
  
  static var previews: some View {
    NameListAddFooter(addAction: {_ in })
  }
}
