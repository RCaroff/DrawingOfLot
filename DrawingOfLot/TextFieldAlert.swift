//
//  TextFieldAlert.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 23/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import SwiftUI

struct TextFieldAlert: View {
  
  @State private var inputText: String = ""
  
  var onValidate: ((String) -> Void)
  var onSingle: (() -> Void) = {}
  
  var body: some View {
    VStack {
      Text("Qui est le/la conjoint(e) ?")
        .font(.headline)
        .padding(.bottom, 30)
      TextField("Entrez le nom du conjoint...", text: $inputText)
      Divider()
      .padding(.bottom, 30)
      Button(action: {
        if self.inputText.count == 0 {
          self.onSingle()
        } else {
          self.onValidate(self.inputText)
        }
        self.dismiss()
      }, label: {
        self.inputText.count == 0 ? Text("Célibataire ?") : Text("Valider")
      })
      
      Spacer()
    }
    .padding(.top, 50)
    .padding([.leading, .trailing], 20)
  }
  
  func present() {
    let alert = UIHostingController(rootView: self)
    alert.preferredContentSize = CGSize(width: 300, height: 200)
    alert.modalPresentationStyle = UIModalPresentationStyle.formSheet
    UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true)
  }
  
  func dismiss() {
    UIApplication.shared.windows[0].rootViewController?.presentedViewController?
      .dismiss(animated: true, completion: nil)
  }
}

struct TextFieldAlert_Previews: PreviewProvider {
    static var previews: some View {
      TextFieldAlert(onValidate: { name in
        
      }) {
        
      }
    }
}
