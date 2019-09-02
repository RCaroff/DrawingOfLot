//
//  NameListAddFooter.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 21/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI
import Combine

struct NameListAddFooter: View {
  
  // MARK: - Public
  @Binding var textFieldValue: String
  var addAction: (() -> Void)
  
  // MARK: - Private
  @State private var isAlertPresented: Bool = false
  @State private var alertFieldValue: String = ""
  
  var body: some View {
    HStack {
      TextField("Ajoutez un nom", text: $textFieldValue)
        .frame(height: 40)
        
      Button(action: {
        if !self.$textFieldValue.wrappedValue
          .replacingOccurrences(of: " ", with: "")
          .isEmpty {
          self.addAction()
        }
      }
      ) {
        Text("+")
          .font(.system(size: 30))
          .foregroundColor(.blue)
          .frame(width: 50, height: 50, alignment: .trailing)
      }
    }
    .padding(.horizontal, 0)
  }
}

struct NameListAddFooter_Previews: PreviewProvider {

  static var previews: some View {
    NameListAddFooter(textFieldValue: .constant(""), addAction: {})
  }
}
